variable "aws_main_vpc_cdir" {
  description = "The CDIR range for the VPC"
  type = string
}

variable "public_a_subnet_cdir" {
  description = "The subnet CDIR range for public a"
  type = string
}

variable "public_b_subnet_cdir" {
  description = "The subnet CDIR range for public b"
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
