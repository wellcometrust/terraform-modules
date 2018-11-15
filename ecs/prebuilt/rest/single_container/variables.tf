variable "service_name" {}

variable "security_group_ids" {
  type = "list"
}

variable "cluster_name" {}
variable "vpc_id" {}

variable "subnets" {
  type = "list"
}

variable "namespace_id" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "container_image" {}
variable "container_port" {}

variable "env_vars" {
  type = "map"
}

variable "env_vars_length" {}

variable "command" {
  type    = "list"
  default = []
}

variable "cpu" {
  default = 512
}

variable "memory" {
  default = 1024
}

variable "launch_type" {
  default = "FARGATE"
}

variable "target_group_protocol" {}

variable "service_egress_security_group_id" {}
