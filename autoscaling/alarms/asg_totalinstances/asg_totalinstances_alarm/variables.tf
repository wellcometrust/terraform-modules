variable "name" {}
variable "comparison_operator" {}
variable "asg_name" {}
variable "period" {}
variable "threshold" {}

variable "treat_missing_data" {
  default = "missing"
}

variable "target_arn" {}
