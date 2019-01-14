variable "task_name" {}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "cpu" {}
variable "memory" {}

variable "app_container_image" {}
variable "app_container_port" {}
variable "app_cpu" {}
variable "app_memory" {}

variable "app_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "app_env_vars_length" {
  default = 0
}

variable "secret_app_env_vars" {
  description = "Secret environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "secret_app_env_vars_length" {
  default = "0"
}

variable "sidecar_container_image" {}
variable "sidecar_container_port" {}
variable "sidecar_cpu" {}
variable "sidecar_memory" {}

variable "sidecar_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "sidecar_env_vars_length" {
  default = 0
}

variable "secret_sidecar_env_vars" {
  description = "Secret environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "secret_sidecar_env_vars_length" {
  default = "0"
}

variable "aws_region" {}

variable "launch_types" {
  type    = "list"
  default = ["FARGATE", "EC2"]
}
