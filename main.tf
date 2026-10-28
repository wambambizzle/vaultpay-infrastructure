provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block            = var.aws_main_vpc_cdir

  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = var.tags
}

resource "aws_subnet" "vaultpay-public-subnet-a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.vaultpay-public-subnet-a
  availability_zone   = var.region-a

  tags = {
    Project = var.project_name
  }
}

resource "aws_subnet" "vaultpay-public-subnet-b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.vaultpay-public-subnet-b
  availability_zone   = var.region-b

  tags = {
    Project = var.project_name
  }
}

