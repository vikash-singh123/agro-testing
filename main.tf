
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "self-host-eks-dev"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}

module "eks_cluster" {
  source = "./EKS"
  aws_region = var.aws_region
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block_1 = var.subnet_cidr_block_1
  subnet_cidr_block_2 = var.subnet_cidr_block_2
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  tags = var.tags
}


