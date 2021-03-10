provider "rancher2" {
  api_url    = var.api_url
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
  insecure   = true
}

provider "aws" {
  region = var.region
}
