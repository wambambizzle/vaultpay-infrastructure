vpc_cdir                     = "10.0.0.0/20"
public_subnet_cidrs          = ["10.0.1.0/24", "10.0.2.0/24"]
region-a                     = "us-east-1a"
region-b                     = "us-east-1b"
app_private_subnet_cdirs            = ["10.0.10.0/24", "10.0.11.0/24"]
db_private_subnet_cdirs             = ["10.0.12.0/24", "10.0.13.0/24"]
project_name                 = "VaultPay"

tags = {
  Name    = "vaultpay-vpc"
  Project = "VaultPay"
}

igw_tags = {
  Name    = "vaultpay-igw"
  Project = "VaultPay"
}

public_route_table_tags = {
  Name    = "vaultpay-public-rt"
  Project = "VaultPay"
}
