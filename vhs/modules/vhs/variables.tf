variable "name" {}

variable "bucket_name_prefix" {
  default = "wellcomecollection-vhs-"
}

variable "table_read_max_capacity" {
  default = 80
}

variable "table_write_max_capacity" {
  default = 300
}

variable "billing_mode" {
  default     = "PAY_PER_REQUEST"
  description = "Should be either PAY_PER_REQUEST or PROVISIONED"
}