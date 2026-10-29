provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cdir
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = var.tags
}

resource "aws_subnet" "public-a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.public_subnet_cidrs[0]
  availability_zone   = var.region-a

  tags = {
    Name    = "vaultpay-public-subnet-a"
    Project = var.project_name
  }
}

resource "aws_subnet" "public-b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.public_subnet_cidrs[1]
  availability_zone   = var.region-b

  tags = {
    Name    = "vaultpay-public-subnet-b"
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = var.igw-tags
}

