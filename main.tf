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

resource "aws_iam_role" "role" {
  name          = "${var.project_name}-ecr-iam-role"
  description   = "The aws iam role for the ECR instance."

  assume_role_policy = data.aws_iam_policy_document.ecr_policy

  tags = {
    Name    = "${var.project_name}-ecr-iam-role"
    Project = var.project_name
  }
}

resource "aws_iam_instance_profile" "ecr_profile" {
  name = "${var.project_name}-ecr-profile"
  role = aws_iam_role.role.name

  tags = {
    Name    = "${var.project_name}-ecr-profile"
    Project = var.project_name
  }
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "${var.project_name}-ecr_policy"
  description = "The AWS IAM policy for ECR instance."
  policy      = data.aws_iam_policy_document.ecr_policy.json
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "session_manager" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "rds_secret" {
  name = "${var.project_name}-rds-secret-read"
  role = aws_iam_role.role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "secretsmanager:GetSecretValue"
        Resource = module.database.db_master_secret_arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_reports" {
  name = "${var.project_name}-s3-reports"
  role = aws_iam_role.role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.runtime.arn}/reports/*"
      }
    ]
  })
}

