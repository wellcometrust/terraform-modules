variable "table_read_max_capacity" {}

variable "table_write_max_capacity" {}

variable "table_name_prefix" {
  default = "vhs-"
}

variable "name" {}

variable "billing_mode" {
  description = "Should be either PAY_PER_REQUEST or PROVISIONED"
}
