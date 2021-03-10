# Build rancher cluster with Terraform

### Requirements
- Valid AWS access_key and secret_key
- Valid rancher access_key and secret_key 

### Deploy Kubernetes Cluster on RKE AWS

```console
#set rke url and  rancher access/secret to terraform environment variables in terrform.tfvars
- api_url             = "eg: https://rancher.3.25.228.157.xip.io"
- rancher2_access_key = ""
- rancher2_secret_key = ""

#set keys to terraform environment variables in terrform.tfvars 
- aws_access          = ""
- aws_secret          = ""

#deploy
$ terraform init && terraform apply -auto-approve

#when you create new catalog, you need to replace with your helm chart url
helm_url = "https://raw.githubusercontent.com/nyipulay-min/labace-gin-helm-repo/master/"

#set domain name ( eg: https://labacegin.default.13.236.137.115.xip.io/ping )  
app_name = "labacegin"

#set ami image name depend on regions ( eg : ap-southeast-2 )
- ami                 = "ami-07059c8f12411bfcb"
```

**HVM AMI LIST**

Region | Type | AMI
-------|------|------
eu-north-1 | HVM | [ami-08b189555c5d2d8c3](https://eu-north-1.console.aws.amazon.com/ec2/home?region=eu-north-1#launchInstanceWizard:ami=ami-08b189555c5d2d8c3)
ap-south-1 | HVM | [ami-0086964cb1ffc4fdb](https://ap-south-1.console.aws.amazon.com/ec2/home?region=ap-south-1#launchInstanceWizard:ami=ami-0086964cb1ffc4fdb)
eu-west-3 | HVM | [ami-088930cafc1ad9f20](https://eu-west-3.console.aws.amazon.com/ec2/home?region=eu-west-3#launchInstanceWizard:ami=ami-088930cafc1ad9f20)
eu-west-2 | HVM | [ami-0fdf07cfd187af004](https://eu-west-2.console.aws.amazon.com/ec2/home?region=eu-west-2#launchInstanceWizard:ami=ami-0fdf07cfd187af004)
eu-west-1 | HVM | [ami-0cea454c576ececbd](https://eu-west-1.console.aws.amazon.com/ec2/home?region=eu-west-1#launchInstanceWizard:ami=ami-0cea454c576ececbd)
ap-northeast-2 | HVM | [ami-0fdb6555f88256d12](https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#launchInstanceWizard:ami=ami-0fdb6555f88256d12)
ap-northeast-1 | HVM | [ami-052c75c3e8757bcd9](https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchInstanceWizard:ami=ami-052c75c3e8757bcd9)
sa-east-1 | HVM | [ami-04e51c9d1edad1bfd](https://sa-east-1.console.aws.amazon.com/ec2/home?region=sa-east-1#launchInstanceWizard:ami=ami-04e51c9d1edad1bfd)
ca-central-1 | HVM | [ami-006a1ff3bf21003b3](https://ca-central-1.console.aws.amazon.com/ec2/home?region=ca-central-1#launchInstanceWizard:ami=ami-006a1ff3bf21003b3)
ap-southeast-1 | HVM | [ami-03b14c67c74644c2b](https://ap-southeast-1.console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchInstanceWizard:ami=ami-03b14c67c74644c2b)
ap-southeast-2 | HVM | [ami-07059c8f12411bfcb](https://ap-southeast-2.console.aws.amazon.com/ec2/home?region=ap-southeast-2#launchInstanceWizard:ami=ami-07059c8f12411bfcb)
eu-central-1 | HVM | [ami-0fc1a9332c246bc56](https://eu-central-1.console.aws.amazon.com/ec2/home?region=eu-central-1#launchInstanceWizard:ami=ami-0fc1a9332c246bc56)
us-east-1 | HVM | [ami-02fe87f853d560d52](https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#launchInstanceWizard:ami=ami-02fe87f853d560d52)
us-east-2 | HVM | [ami-004259f4c48585992](https://us-east-2.console.aws.amazon.com/ec2/home?region=us-east-2#launchInstanceWizard:ami=ami-004259f4c48585992)
us-west-1 | HVM | [ami-0b382b76fadc95544](https://us-west-1.console.aws.amazon.com/ec2/home?region=us-west-1#launchInstanceWizard:ami=ami-0b382b76fadc95544)
us-west-2 | HVM | [ami-0cdefa6a0646eb511](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#launchInstanceWizard:ami=ami-0cdefa6a0646eb511)

