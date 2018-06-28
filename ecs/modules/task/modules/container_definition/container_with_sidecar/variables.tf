variable "aws_region" {}

variable "task_name" {}
variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "sidecar_is_proxy" {
  default = false
}

# App

variable "app_container_image" {}
variable "app_container_port" {
  default = "1337"
}

variable "app_cpu" {}
variable "app_memory" {}

variable "app_mount_points" {
  type    = "list"
  default = []
}

variable "app_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

# Sidecar

variable "sidecar_container_image" {}
variable "sidecar_container_port" {
  default = "1337"
}

variable "sidecar_cpu" {}
variable "sidecar_memory" {}

variable "sidecar_mount_points" {
  type    = "list"
  default = []
}

variable "sidecar_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}