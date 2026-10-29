vpc_cdir                     = "10.0.0.0/20"
public_subnet_cidrs          = ["10.0.1.0/24", "10.0.2.0/24"]
region-a                     = "us-east-1a"
region-b                     = "us-east-1b"

private_app_a_subnet_cdir    = "10.0.10.0/24"
private_app_b_subnet_cdir    = "10.0.11.0/24"
private_db_a_subnet_cdir     = "10.0.12.0/24"
private_db_b_subnet_cdir     = "10.0.13.0/24"
project_name                 = "VaultPay"

tags = {
  Name    = "vaultpay-vpc"
  Project = "VaultPay"
}

igw-tags = {
  Name    = "vaultpay-igw"
  Project = "VaultPay"
}

route-table-tags = {
  Name    = "vaultpay-public-rt"
  Project = "VaultPay"
}
