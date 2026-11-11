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
  app_private_subnet_cidrs  = var.app_private_subnet_cidrs
}

resource "aws_iam_role" "app" {
  name          = "${var.project_name}-app-role"
  description   = "The IAM role assumed by VaultPay application EC2 instances"

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name    = "${var.project_name}-app-role"
    Project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "app_runtime" {
  name   = "${var.project_name}-app-runtime"
  role   = aws_iam_role.app.id
  policy = data.aws_iam_policy_document.app_runtime.json
}

resource "aws_iam_instance_profile" "app" {
  name = "${var.project_name}-app-profile"
  role = aws_iam_role.app.name

  tags = {
    Name    = "${var.project_name}-app-profile"
    Project = var.project_name
  }
}

resource "aws_security_group" "alb" {
  name        = "vaultpay-alb-sg"
  description = "Security group for the VaultPay ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "ALB to public subnets"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ALB secure to public subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-alb-sg"
    Project = var.project_name
  }
}
