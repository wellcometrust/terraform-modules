variable "name" {}
variable "cluster_name" {}
variable "service_name" {}

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

variable "metric_interval_lower_bound_scale_up" {
  default = 0
}

variable "metric_interval_upper_bound_scale_down" {
  default = 0
}
