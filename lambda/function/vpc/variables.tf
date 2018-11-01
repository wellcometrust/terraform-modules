variable "s3_bucket" {}
variable "s3_key" {}
variable "description" {}
variable "name" {}
variable "iam_role_name" {}
variable "module_name" {}
variable "timeout" {}
variable "memory_size" {}
variable "lambda_dlq_arn" {}

variable "environment_variables" {
  type = "map"
}

variable "security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}
