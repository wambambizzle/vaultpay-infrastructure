resource "aws_ecr_repository" "vaultpay" {
  name                 = "vaultpay-ecr-app-image"
  # image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${var.project_name}-ecr-repository"
    Project = var.project_name
  }
}