variable "table_name_prefix" {
  default = "vhs-"
}

variable "name" {}

variable "billing_mode" {
  description = "Should be either PAY_PER_REQUEST or PROVISIONED"
}
