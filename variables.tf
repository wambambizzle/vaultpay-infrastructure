variable "aws_main_vpc_cdir" {
  description = "The CDIR range for the VPC"
  type = string
}

variable "vaultpay-public-subnet-a" {
  description = "The subnet CDIR range for public a"
  type = string
}

variable "vaultpay-public-subnet-b" {
  description = "The subnet CDIR range for public b"
  type = string
}

variable "region-a" {
  description = "The region for A"
  type = string
}

variable "region-b" {
  description = "The region for B"
  type = string
}

variable "private_app_a_subnet_cdir" {
  description = "The subnet CDIR range for private app a"
  type = string
}

variable "private_app_b_subnet_cdir" {
  description = "The subnet CDIR range for private app b"
  type = string
}

variable "private_db_a_subnet_cdir" {
  description = "The subnet CDIR range for private db a"
  type = string
}

variable "private_db_b_subnet_cdir" {
  description = "The subnet CDIR range for private db b"
  type = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type = map(string)
}

variable "project_name" {
  description = "The name of the Project"
  type = string
}