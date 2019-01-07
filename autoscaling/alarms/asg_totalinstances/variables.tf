variable "name" {}

variable "asg_name" {}

variable "scale_up_arn" {}
variable "scale_down_arn" {}

variable "treat_missing_data_high" {
  default = "missing"
}

variable "treat_missing_data_low" {
  default = "missing"
}

variable "high_period" {
  default = "60"
}

variable "high_threshold" {
  default = "1"
}

variable "low_period" {
  default = "600"
}

variable "low_threshold" {
  default = "1"
}
