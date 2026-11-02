variable "vpc_id" {
  description = "The id of the VPC to associate to"
  type        = string
}

variable "db_private_subnet_ids" {
  description = "The database private subnets to use"
  type        = list(string)
}

variable "project_name" {
  description = "The name used for resource naming and tags"
  type        = string
}