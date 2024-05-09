
provider "aws" {
  region = var.aws_region
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


