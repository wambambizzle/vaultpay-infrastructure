provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  project_name              = var.project_name
  vpc_cdir                  = var.vpc_cdir
  public_subnet_cidrs       = var.public_subnet_cidrs
  app_private_subnet_cdirs  = var.app_private_subnet_cdirs
  db_private_subnet_cdirs   = var.db_private_subnet_cdirs 
}