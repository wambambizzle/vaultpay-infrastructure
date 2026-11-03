provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                    = "./modules/vpc"
  project_name              = var.project_name
  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  app_private_subnet_cidrs  = var.app_private_subnet_cidrs
  db_private_subnet_cidrs   = var.db_private_subnet_cidrs 
}

module "database" {
  source                  = "./modules/database"
  project_name            = var.project_name
  db_private_subnet_ids   = module.vpc.db_private_subnet_ids
  vpc_id                  = module.vpc.vpc_id
  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention_period 
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
}
