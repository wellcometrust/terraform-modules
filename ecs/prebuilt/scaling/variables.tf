variable "cluster_name" {}
variable "cluster_id" {}

variable "service_name" {}

variable "container_image" {}

variable "service_egress_security_group_id" {}

variable "env_vars" {
  type = "map"
}

variable "env_vars_length" {}

variable "secret_env_vars" {
  type = "map"
}

variable "secret_env_vars_length" {}

variable "launch_type" {
  default = "FARGATE"
}

variable "cpu" {
  default = 512
}

variable "memory" {
  default = 1024
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "subnets" {
  type = "list"
}

variable "namespace_id" {}

variable "min_capacity" {
  default = 1
}

variable "max_capacity" {
  default = 3
}

variable "desired_task_count" {
  default = 1
}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "high_metric_name" {}

variable "low_metric_name" {
  default = ""
}

variable "metric_namespace" {}

variable "command" {
  type    = "list"
  default = []
}

variable "container_port" {
  default = "80"
}
