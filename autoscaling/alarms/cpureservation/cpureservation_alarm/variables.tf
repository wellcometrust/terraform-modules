variable "name" {}
variable "comparison_operator" {}
variable "cluster_name" {}
variable "period_in_minutes" {}
variable "threshold" {}

variable "treat_missing_data" {
  default = "missing"
}

variable "target_arn" {}
