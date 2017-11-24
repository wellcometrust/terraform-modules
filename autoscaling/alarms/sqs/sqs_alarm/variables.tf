variable "name" {}
variable "comparison_operator" {}
variable "queue_name" {}
variable "period" {}
variable "threshold" {}
variable "target_arn" {}

variable "treat_missing_data" {
  default = "missing"
}
