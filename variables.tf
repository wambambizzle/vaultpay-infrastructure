variable "vpc_cdir" {
  description = "The CDIR range for the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type = list(string)
}

variable "region-a" {
  description = "The region for A"
  type = string
}

variable "region-b" {
  description = "The region for B"
  type = string
}

variable "app_private_subnet_cdirs" {
  description = "CIDR blocks for the private app subnets"
  type = list(string)
}

variable "db_private_subnet_cdirs" {
  description = "CIDR blocks for the private db subnets"
  type = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type = map(string)
}

variable "igw_tags" {
  description = "Tags to apply to resources"
  type = map(string)
}

variable "public_route_table_tags" {
  description = "Tags to apply to resources"
  type = map(string)
}

variable "project_name" {
  description = "The name of the Project"
  type = string
}
