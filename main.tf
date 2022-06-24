terraform {
  required_version = ">=0.13.1"
  required_providers {
    aws   = ">=3.54.0"
    local = ">=2.1.0"
  }
  # backend "s3" {
  #   bucket = "myfcbucket"
  #   key    = "terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = "us-east-1"
}

module "new-vpc" {
  source         = "./modules/vpc"
  prefix         = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "new-key-pair" {
  source = "./modules/key_pair"
}

module "new-ec2" {
  source            = "./modules/ec2"
  prefix            = var.prefix
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_ids        = module.new-vpc.subnet_ids
  vpc_id            = module.new-vpc.vpc_id
  security_group    = module.new-vpc.security_group
  network_interface = module.new-vpc.network_interface
  key_name          = module.new-key-pair.key_name
}

# module "eks" {
#     source = "./modules/eks"
#     prefix = var.prefix
#     vpc_id = module.new-vpc.vpc_id
#     cluster_name = var.cluster_name
#     retention_days = var.retention_days
#     subnet_ids = module.new-vpc.subnet_ids
#     desired_size = var.desired_size
#     max_size = var.max_size
#     min_size = var.min_size
# }
