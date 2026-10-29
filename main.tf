provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cdir
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = var.tags
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

resource "aws_subnet" "app_private_a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.app_private_subnet_cdirs[0]
  availability_zone   = var.region-a

  tags = {
    Name    = "vaultpay-app-private-subnet-a"
    Project = var.project_name
  }
}

resource "aws_subnet" "app_private_b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.app_private_subnet_cdirs[1]
  availability_zone   = var.region-b

  tags = {
    Name    = "vaultpay-app-private-subnet-b"
    Project = var.project_name
  }
}

resource "aws_subnet" "private_db_a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.db_private_subnet_cdirs[0]
  availability_zone   = var.region-a

  tags = {
    Name    = "vaultpay-db-private-subnet-a"
    Project = var.project_name
  }
}

resource "aws_subnet" "private_db_b" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.db_private_subnet_cdirs[1]
  availability_zone   = var.region-b

  tags = {
    Name    = "vaultpay-db-private-subnet-b"
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

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name    = "vaultpay-private-rt"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app_private_a" {
  subnet_id      = aws_subnet.app_private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "app_private_b" {
  subnet_id      = aws_subnet.app_private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "public_static_ip" {
  domain = "vpc"

  tags = {
    Name    = "vaultpay-public-static-ip"
    Project = var.project_name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.public_static_ip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name    = "nat-gateway"
    Project = var.project_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

