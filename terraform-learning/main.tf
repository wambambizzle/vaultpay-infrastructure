provider "aws" {
  region = "us-east-1"
}
    
resource "aws_s3_bucket" "team_files" {
  bucket = "j-tf-learning-bucket"

  tags = {
    Project = "terraform-learning"
    Owner = "j-iam-admin"
  }
}
