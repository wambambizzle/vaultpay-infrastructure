provider "aws" {
  region = "us-east-1"
}
    
resource "aws_s3_bucket" "first_bucket" {
  bucket = "${var.owner}-tf-learning-bucket"

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "first_bucket" {
  bucket = aws_s3_bucket.first_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
