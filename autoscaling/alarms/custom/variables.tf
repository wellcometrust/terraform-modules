variable "name" {}

variable "scale_up_arn" {}
variable "scale_down_arn" {}

variable "high_period_in_minutes" {
  default = 1
}

variable "high_threshold" {
  default = 1
}

variable "low_period_in_minutes" {
  default = 1
}

variable "low_threshold" {
  default = 1
}

variable "high_metric_name" {}
variable "low_metric_name" {}

variable "namespace" {}
