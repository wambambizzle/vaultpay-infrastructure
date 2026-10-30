variable "project_name" {
  description = "The name used for resource naming and tags"
  type        = string
}

variable "vpc_cdir" {
  description = "The CDIR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "app_private_subnet_cdirs" {
  description = "CIDR blocks for the app private subnets"
  type        = list(string)
}

variable "db_private_subnet_cdirs" {
  description = "CIDR blocks for the database private subnets"
  type        = list(string)
}
