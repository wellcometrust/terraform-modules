variable "cluster_name" {}
variable "source_queue_name" {}
variable "source_queue_arn" {}
variable "name" {}
variable "vpc_id" {}
variable "ecr_repository_url" {}
variable "release_id" {}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 1024
}

variable "env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
}

variable "env_vars_length" {}

variable "alb_priority" {
  description = "ALB listener rule priority.  If blank, a priority will be randomly assigned."
  default     = ""
}

variable "alb_listener_https_arn" {}
variable "alb_listener_http_arn" {}
variable "alb_cloudwatch_id" {}
variable "alb_server_error_alarm_arn" {}
variable "alb_client_error_alarm_arn" {}

variable "enable_alb_alarm" {
  default = 1
}
