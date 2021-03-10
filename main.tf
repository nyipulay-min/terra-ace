module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = var.vpc.vpc_name
  cidr = var.vpc.cidr

  azs             = var.vpc.azs
  private_subnets = var.vpc.pri_sub
  public_subnets  = var.vpc.pub_sub

  enable_nat_gateway     = var.vpc.is_enable_natgw
  enable_vpn_gateway     = var.vpc.is_enable_vpngw
  single_nat_gateway     = var.vpc.is_single_natgw
  one_nat_gateway_per_az = var.vpc.is_one_natgw_per_az
}

resource "rancher2_cloud_credential" "credential_ec2" {
  name = "EC2 Credentials"
  amazonec2_credential_config {
    access_key = var.aws_access
    secret_key = var.aws_secret
  }
}

resource "aws_security_group" "k8s_sg_allowall" {
  name        = "labace-k8s-allowall"
  description = "LabACE k8s - allow all traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   depends_on = [module.vpc]
}

# Create a new rancher2 Node Template
resource "rancher2_node_template" "labace" {
  name                = var.cluster_name
  description         = "labace"
  cloud_credential_id = rancher2_cloud_credential.credential_ec2.id
  amazonec2_config {
    access_key     = var.aws_access
    secret_key     = var.aws_secret
    ssh_user       = var.ssh_user
    ami            = var.ami
    instance_type  = var.instance_type
    root_size      = var.disk_size
    region         = var.region
    security_group = [aws_security_group.k8s_sg_allowall.name]
    subnet_id      = module.vpc.public_subnets[0]
    vpc_id         = module.vpc.vpc_id
    zone           = substr(module.vpc.azs[0], 14, 15)
  }
  depends_on = [rancher2_cloud_credential.credential_ec2, aws_security_group.k8s_sg_allowall]
}

resource "rancher2_cluster" "labace" {
  name        = var.cluster_name
  description = "Terraform"

  rke_config {
    kubernetes_version    = var.k8s_version
    ignore_docker_version = false
    network {
      plugin = "flannel"
    }
    services {
      etcd {
        backup_config {
          enabled = false
        }
      }
      kubelet {
        extra_args = {
          max_pods = 70
        }
      }
    }
  }

  depends_on = [rancher2_node_template.labace]
}


# Create a new rancher2 Node Pool
resource "rancher2_node_pool" "labace" {
  cluster_id       = rancher2_cluster.labace.id
  name             = var.cluster_name
  hostname_prefix  = join("-", [var.cluster_name, "cluster-"])
  node_template_id = rancher2_node_template.labace.id
  quantity         = var.num_of_node
  control_plane    = true
  etcd             = true
  worker           = true

  depends_on = [rancher2_node_template.labace]
}

resource "rancher2_cluster_sync" "sync_ec2" {
  cluster_id    = rancher2_cluster.labace.id
  node_pool_ids = [rancher2_node_pool.labace.id]
}

resource "null_resource" "before" {
  depends_on = [rancher2_cluster.labace, rancher2_node_pool.labace]
}

resource "rancher2_app" "nginx-ingress" {
  project_id = rancher2_cluster_sync.sync_ec2.default_project_id
  name = "nginx-ingress"
  target_namespace = var.namespace
  catalog_name = "helm3-library"
  template_name = "nginx-ingress"
  template_version = "0.7.1"


  depends_on = [rancher2_cluster.labace,rancher2_cluster_sync.sync_ec2]
}


resource "rancher2_catalog" "labace-gin" {
  name = var.catalog_name
  url = var.helm_url
  kind = "helm"
  version = "helm_v3"
  depends_on = [rancher2_cluster.labace]
}

resource "rancher2_app" "labace-gin" {
  project_id = rancher2_cluster_sync.sync_ec2.default_project_id
  name = var.app_name
  target_namespace = var.namespace
  catalog_name = rancher2_catalog.labace-gin.name
  template_name = var.chart_name

  depends_on = [rancher2_catalog.labace-gin,rancher2_cluster.labace,rancher2_cluster_sync.sync_ec2,rancher2_app.nginx-ingress]
}
