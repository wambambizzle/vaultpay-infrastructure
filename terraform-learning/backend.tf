terraform {
  backend "s3" {
    bucket        = "532404260821-terraform-state"
    key           = "vaultpay-infrastructure/terraform-learning/terraform.tfstate"
    region        = "us-east-1"
    encrypt       = true
    use_lockfile  = true   
  }
}