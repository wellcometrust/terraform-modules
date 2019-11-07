variable "aws_region" {}

variable "task_name" {}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

# App

variable "app_container_image" {}

variable "app_port_mappings_string" {
  default = "[]"
}

variable "app_cpu" {}
variable "app_memory" {}

variable "app_mount_points" {
  type    = "list"
  default = []
}

variable "app_env_vars" {
  type    = "map"
  default = {}
}

variable "app_env_vars_length" {
  default = 0
}

variable "secret_app_env_vars" {
  type    = "map"
  default = {}
}

variable "secret_app_env_vars_length" {
  default = 0
}

# Sidecar

variable "sidecar_container_image" {}

variable "sidecar_port_mappings_string" {
  default = "[]"
}

variable "sidecar_cpu" {}
variable "sidecar_memory" {}

variable "sidecar_mount_points" {
  type    = "list"
  default = []
}

variable "sidecar_env_vars" {
  type    = "map"
  default = {}
}

variable "sidecar_env_vars_length" {
  default = 0
}

variable "secret_sidecar_env_vars" {
  type    = "map"
  default = {}
}

variable "secret_sidecar_env_vars_length" {
  default = 0
}

variable "execution_role_name" {}

variable "app_user" {
  default = "root"
}

variable "sidecar_user" {
  default = "root"
}
