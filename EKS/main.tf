
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

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

# Subnets
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block_1
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block_2
  availability_zone = "ap-south-1b"
}

# IAM Role
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks_cluster_role12"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  // Add inline policy
  inline_policy {
    name = "eks_cluster_policy"
    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "eks:CreateCluster",
            "eks:DescribeCluster",
            "eks:TagResource",
            "eks:UntagResource"
          ],
          "Resource": "*"
        }
      ]
    })
  }
}
  
# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  }
 
  tags = var.tags
}
