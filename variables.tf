variable "aws_region" {
  description = "AWS region"
  type = string
  default = "ap-south-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
  default = "Self-Hosted-Cluster-Dev"
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type = number
  default = 1.29
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type = string
  default     = "10.0.0.0/24"
}

variable "subnet_cidr_block_1" {
  description = "CIDR block for subnet 1"
  type = string
  default     = "10.0.0.0/25"
}

variable "subnet_cidr_block_2" {
  description = "CIDR block for subnet 2"
  type = string
  default     = "10.0.0.128/25"
}

variable "tags" {
  description = "Tags to apply to resources"
   default     = {
    Environment = "DEV"
    Owner       = "Self-Hosted"
    # Add more default tags as needed
  }

}