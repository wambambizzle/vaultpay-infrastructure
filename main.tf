provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block            = "10.0.0.0/20"
  instance_tenancy      = "default"

  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name = "vaultpay-vpc"
    Project = "VaultPay"
  }
}
