variable "task_name" {}

variable "env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "container_image" {}

variable "container_port" {
  default = "false"
}

variable "cpu" {
  default = 512
}

variable "memory" {
  default = 1024
}

variable "aws_region" {}

variable "env_vars_length" {
  default = 0
}
