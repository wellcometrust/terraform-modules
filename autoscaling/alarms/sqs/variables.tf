variable "name" {}
variable "queue_name" {}

variable "scale_up_arn" {}
variable "scale_down_arn" {}

variable "scale_up_adjustment" {
  default = 1
}

variable "scale_down_adjustment" {
  default = -1
}

variable "min_capacity" {
  default = 0
}

variable "max_capacity" {
  default = 3
}

variable "high_period" {}

variable "high_threshold" {
  default = 1
}

variable "low_period" {}

variable "low_threshold" {
  default = 1
}
