variable "aws_region" {}

variable "env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "task_name" {}

variable "task_port" {
  default = "false"
}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "container_image" {}

variable "cpu" {}
variable "memory" {}

variable "mount_points" {
  type    = "list"
  default = []
}

variable "env_vars_length" {
  default = 0
}
