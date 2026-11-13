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
  name        = "${var.project_name}-alb-sg"
  description = "Allow inbound HTTP from the interenet to the VaultPay ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound (ALB to targets)"
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

resource "aws_lb" "app" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb.id]
  subnets            = module.vpc.public_subnet_ids

  tags = {
    Name    = "${var.project_name}-alb"
    Project = var.project_name
  }
}

resource "aws_lb_target_group" "app" {
  name        = "${var.project_name}-tg"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
  port        = 80
  protocol    = "HTTP"

  health_check {
    enabled             = true
    path                = "/health"
    matcher             = "200"
    protocol            = "HTTP" 
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name    = "${var.project_name}-tg"
    Project = var.project_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Allow inbound HTTP from the interenet to the VaultPay ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "HTTP from anywhere"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "All outbound (ALB to targets)"
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