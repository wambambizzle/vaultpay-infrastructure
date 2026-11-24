variable "project_name" {
  description = "Project name used for resource naming and tags."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the application tier will be deployed."
  type        = string
}

variable "db_name" {
  description = "The name of the PostgreSQL database inside RDS."
  type        = string
}

variable "db_endpoint" {
  description = "The RDS endpoint in 'host:port' form. The module extracts the host and passes it to the container."
  type        = string
}

variable "db_port" {
  description = "The port number for the RDS instance."
  type        = string
}

variable "db_master_secret_arn" {
  description = "The ARN of the Secrets Manager secret holding the RDS master credentials. The instance role is scoped to read only this secret."
  type        = string
}

variable "s3_force_destroy" {
  description = "When true, terraform destroy will delete the runtime S3 bucket even if it contains objects."
  type        = bool
  # The dangerous behavior should be protected as a default so we can't forget and do something "silly"
  default     = false
}

variable "ecr_force_delete" {
  description = "When true, terraform destroy will delete the ECR repository even if it contains images."
  type        = bool
  default     = false
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the ALB."
  type        = list(string)
}

variable "app_private_subnet_ids" {
  description = "A list of app-private subnet IDs for the Auto Scaling Group."
  type        = list(string)
}

variable "image_tag" {
  description = "Tag of the VaultPay container image in ECR that the launch template tells instances to pull."
  type        = string
  default     = "latest"
}

variable "app_security_group_id" {
  description = "Security group ID assigned to the application EC2 instances. The database module's SG is configured to allow ingress from this SG."
  type        = string
}
