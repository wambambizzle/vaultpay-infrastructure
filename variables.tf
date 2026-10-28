variable "vpc-cdir" {
  description = "The CDIR range for the VPC"
  type = string
}

variable "public-a-subnet-cdir" {
  description = "The subnet CDIR range for public a"
  type = string
}

variable "public-b-subnet-cdir" {
  description = "The subnet CDIR range for public b"
  type = string
}

variable "private-app-a-subnet-cdir" {
  description = "The subnet CDIR range for private app a"
  type = string
}

variable "private-app-b-subnet-cdir" {
  description = "The subnet CDIR range for private app b"
  type = string
}

variable "private-db-a-subnet-cdir" {
  description = "The subnet CDIR range for private db a"
  type = string
}

variable "private-db-b-subnet-cdir" {
  description = "The subnet CDIR range for private db b"
  type = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type = map(string)
}
