variable "admin_principals" {
  type = "list"
}

variable "billing_principals" {
  type = "list"
}

variable "developer_principals" {
  type = "list"
}

variable "monitoring_principals" {
  type = "list"
}

variable "infrastructure_principals" {
  type = "list"
}

variable "read_only_principals" {
  type = "list"
}

variable "auth_type" {
  default = "aws"
}

