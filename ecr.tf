resource "aws_ecr_repository" "vaultpay" {
  name         = "vaultpay-ecr-app-image"

  # DESTORY GUARD TOGGLE
  force_delete = var.force_delete

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${var.project_name}-ecr-repository"
    Project = var.project_name
  }
}

data "aws_caller_identity" "vaultpay" {}

resource "aws_s3_bucket" "vaultpay_run_time" {
  bucket        = "${data.aws_caller_identity.vaultpay.account_id}-vaultpay-s3-runtime"

  # DESTORY GUARD TOGGLE
  force_destroy = var.force_destroy

  tags = {
    Name    = "${var.project_name}-s3-run-time"
    Project = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.vaultpay_run_time.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
