variable "name" {}
variable "comparison_operator" {}
variable "period_in_minutes" {}
variable "threshold" {}
variable "target_arn" {}
variable "metric_name" {}
variable "statistic" {}

variable "treat_missing_data" {
  default = "missing"
}

variable "namespace" {}

variable "period" {
  default = "60"
}
