variable "prefix" {}
variable "ami" {}
variable "instance_type" {}
variable "subnet_ids" {}
variable "vpc_id" {}
variable "security_group" {}
variable "network_interface" {}
variable "key_name" {}
variable "instances" {
  description = "Map of modules names to configuration."
  type        = map(any)
  default = {
    ec2_1 = {
      name          = "rancher-server",
      instance_id   = 0,
      instance_type = "t3.micro",
      environment   = "dev"
    },
    ec2_2 = {
      name          = "k8s-1",
      instance_id   = 1,
      instance_type = "t3.micro",
      environment   = "test"
    }
  }
}
