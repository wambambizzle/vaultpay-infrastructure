provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cdir
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = var.tags
}

resource "aws_subnet" "private_app_a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.private_app_cdirs[0]
  availability_zone   = var.region-a

  tags = {
    Name    = "vaultpay-private-app-subnet-a"
    Project = var.project_name
  }
}

resource "aws_subnet" "private_app_b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.private_app_cdirs[1]
  availability_zone   = var.region-b

  tags = {
    Name    = "vaultpay-private-app-subnet-b"
    Project = var.project_name
  }
}

resource "aws_subnet" "private_db_a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.private_db_cdirs[0]
  availability_zone   = var.region-a

  tags = {
    Name    = "vaultpay-private-db-subnet-a"
    Project = var.project_name
  }
}

resource "aws_subnet" "private_db_b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.private_db_cdirs[1]
  availability_zone   = var.region-b

  tags = {
    Name    = "vaultpay-private-db-subnet-b"
    Project = var.project_name
  }
}

resource "aws_subnet" "public_a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.public_subnet_cidrs[0]
  availability_zone   = var.region-a

  tags = {
    Name    = "vaultpay-public-subnet-a"
    Project = var.project_name
  }
}

resource "aws_subnet" "public_b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.public_subnet_cidrs[1]
  availability_zone   = var.region-b

  tags = {
    Name    = "vaultpay-public-subnet-b"
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = var.igw_tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = var.public_route_table_tags
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
