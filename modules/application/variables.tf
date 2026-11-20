# General

variable "project_name" {
  description = "The name used for resource naming and tags"
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