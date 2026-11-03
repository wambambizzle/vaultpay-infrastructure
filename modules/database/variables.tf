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

variable "multi_az" {
  description = "Multi avaialbity zone"
  type        = bool
}

variable "backup_retention_period" {
  description = "The backup retention period"
  type        = number
}

variable "deletion_protection" {
  description = "If the server has deletion protection"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "If RDS should skip the final snapshot"
  type        = bool
}

variable "db_name" {
  description = "The rds database name"
  type        = string
}

variable "db_username" {
  description = "The rds database username"
  type        = string
}
