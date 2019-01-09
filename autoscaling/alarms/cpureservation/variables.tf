variable "name" {}

variable "cluster_name" {}

variable "scale_up_arn" {}
variable "scale_down_arn" {}

variable "treat_missing_data_high" {
  default = "missing"
}

variable "treat_missing_data_low" {
  default = "missing"
}

variable "high_period_in_minutes" {}

variable "high_threshold" {
  default = "80"
}

variable "low_period_in_minutes" {}

variable "low_threshold" {
  default = "80"
}
