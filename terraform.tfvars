api_url             = "https://rancher.3.25.228.157.xip.io"
rancher2_access_key = "token-"
rancher2_secret_key = "99kwj2ltmc"
cluster_name        = "labace"
aws_access          = "AKIAYL"
aws_secret          = "CG6/w"
region              = "ap-southeast-2"
k8s_version         = "v1.18.3-rancher2-2"
ami                 = "ami-07059c8f12411bfcb"
ssh_user            = "rancher"
num_of_node         = 3
instance_type       = "t3.xlarge"
disk_size           = 50

vpc = { vpc_name = "labace", cidr = "10.10.0.0/16", azs = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"], pri_sub = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"], pub_sub = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24"], is_enable_natgw = true, is_enable_vpngw = false, is_single_natgw = true, is_one_natgw_per_az = false }

catalog_name = "ginace"
helm_url = "https://raw.githubusercontent.com/nyipulay-min/labace-gin-helm-repo/master/"

chart_name = "gin"
app_name = "labacegin"
