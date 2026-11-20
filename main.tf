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
  source                    = "./modules/database"

  project_name              = var.project_name
  db_private_subnet_ids     = module.vpc.db_private_subnet_ids
  vpc_id                    = module.vpc.vpc_id
  multi_az                  = var.multi_az
  backup_retention_period   = var.backup_retention_period 
  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  db_name                   = var.db_name
  db_username               = var.db_username
  app_sg_id                 = aws_security_group.app.id
}

module "application" {
  source                  = "./modules/application"

  project_name            = var.project_name
  vpc_id                  = module.vpc.vpc_id
  lb_public_subnet_ids    = module.vpc.public_subnet_ids
  app_sg_id               = aws_security_group.app.id
  db_master_secret_arn    = module.database.db_master_secret_arn 
  db_endpoint             = module.database.db_endpoint
  db_port                 = module.database.db_port
  db_name                 = var.db_name
  image_tag               = var.image_tag
  app_private_subnet_ids  = module.vpc.app_private_subnet_ids
  ecr_force_delete        = var.ecr_force_delete
  s3_force_destroy        = var.s3_force_destroy
}

# Stays at the Root for shared use
resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Allow inbound HTTP from the interenet to the VaultPay ALB"
  vpc_id      = module.vpc.vpc_id

  egress {
    description = "All outbound (ECR, Secrets Manager, RDS, etc. via NAT)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-app-sg"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg_ingress_rule" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = module.application.alb_security_group_id
  description                  = "HTTP from anywhere"
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}
