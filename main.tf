provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block            = var.vpc-cdir

  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = var.tags
}
