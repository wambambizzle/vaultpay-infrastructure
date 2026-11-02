resource "aws_db_subnet_group" "db" {
  description = "Database private subnet group"
  subnet_ids = var.db_private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-private-subnet-group"
    Project = var.project_name
  }
}

resource "aws_security_group" "db-sg" {
  vpc_id = var.vpc_id
  
  ingress = []

  egress { 
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-db-private-sg"
    Project = var.project_name
  }
}
