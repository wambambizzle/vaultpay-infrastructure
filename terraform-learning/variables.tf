variable "owner" {
  description = "Owner name"
  type = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type = map(string)
}
