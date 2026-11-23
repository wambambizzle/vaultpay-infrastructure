# General

variable "project_name" {
  description = "The name used for resource naming and tags"
  type        = string
}

variable "vpc_id" {
  description = "The id of the VPC to associate to"
  type        = string
}

# Database

variable "db_name" {
  description = "The rds database name"
  type        = string
}

variable "db_endpoint" {
  description = "The endpoint address of the RDS database instance."
  type        = string
}

variable "db_port" {
  description = "The port for the RDS database"
  type        = string
}

variable "db_master_secret_arn" {
  description = "The master secret arn for the RDS database"
  type        = string
}

# ECR and Containers

# The dangerous behavior should be protected as a default so we can't forget and do something "silly"
variable "s3_force_destroy" {
  description = "If the aws S3 bucket should allow force deletion"
  type        = bool
  default     = false
}

variable "ecr_force_delete" {
  description = "If the aws ecr repository should allow force deletion"
  type        = bool
  default     = false
}

# VPC

variable "public_subnet_ids" {
  description = "The IDs the load balancers public subnets"
  type        = list(string)
}

variable "app_private_subnet_ids" {
  description = "IDs of the app private subnets"
  type        = list(string)
}

# Boot Script

variable "image_tag" {
  description = "Container image tag to deploy."
  type        = string
  default     = "latest"
}

variable "app_security_group_id" {
  description = "The app security group id"  
  type        = string
}
