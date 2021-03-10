variable "rancher2_access_key" {
  type = string
}
variable "rancher2_secret_key" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "aws_access" {
  type = string
}

variable "aws_secret" {
  type = string
}

variable "region" {
  type = string
}

variable "k8s_version" {
  type = string
}

variable "ami" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "num_of_node" {
  type = number
}

variable "api_url" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "disk_size" {
  type    = number
  default = 32
}

variable "vpc" {
  type = object({
    vpc_name            = string
    cidr                = string
    azs                 = list(string)
    pri_sub             = list(string)
    pub_sub             = list(string)
    is_enable_natgw     = bool
    is_enable_vpngw     = bool
    is_single_natgw     = bool
    is_one_natgw_per_az = bool
  })
  description = "AWS VPC Variables"
}

variable "app_name" {
  type = string
}

variable "helm_url" {
  type = string
}

variable "catalog_name" {
  type = string
}

variable "namespace" {
  type = string
  default = "default" 
}

variable "chart_name" {
  type = string
}
