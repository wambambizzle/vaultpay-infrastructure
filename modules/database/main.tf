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
