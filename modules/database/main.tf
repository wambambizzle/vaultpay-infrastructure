resource "aws_db_instance" "vaultpay" {
  allocated_storage           = 10
  db_name                     = "${var.project_name}-pg-db"
  db_subnet_group_name        = aws_db_subnet_group.vaultpay.name
  engine                      = "postgres"
  engine_version              = "12.0"
  instance_class              = "db.t3.micro"
  manage_master_user_password = true
  # TODO: ENV var?
  availability_zone           = "us-east-1a"
  publicly_accessible         = false
  storage_encrypted           = true
  deletion_protection         = false
  skip_final_snapshot         = true

  tags = {
    Name    = "${var.project_name}-rds-pg-db"
    Project = var.project_name
  }
}


resource "aws_db_subnet_group" "vaultpay" {
  name        = "vaultpay-db-subnet-group"
  description = "Subnets available for VaultPay RDS database placement"
  subnet_ids  = var.db_private_subnet_ids

  tags = {
    Name    = "${var.project_name}-db-subnet-group"
    Project = var.project_name
  }
}

resource "aws_security_group" "rds" {
  name        = "vaultpay-rds-sg"
  description = "Security group for the VaultPay RDS instance"
  vpc_id      = var.vpc_id
  
  ingress = []

  egress { 
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-rds-sg"
    Project = var.project_name
  }
}
