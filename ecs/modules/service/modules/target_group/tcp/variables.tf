variable "service_name" {}
variable "container_port" {}
variable "vpc_id" {}
variable "lb_arn" {}
variable "listener_port" {}
variable "deregistration_delay" {
  default = 300
}
