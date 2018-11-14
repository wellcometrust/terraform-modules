variable "api_id" {}
variable "resource_id" {}

variable "http_method" {
  default = "GET"
}

variable "aws_region" {}
variable "bucket_name" {}
variable "s3_key" {}

variable "static_resource_role_arn" {}