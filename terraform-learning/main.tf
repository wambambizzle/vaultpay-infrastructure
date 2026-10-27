provider "aws" {
  region = "us-east-1"
}
  
module "bucket" {
  source    = "./modules/s3-bucket"

  bucket_name = var.owner
  environment = "dev"
}
