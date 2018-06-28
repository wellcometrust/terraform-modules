variable "task_name" {}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "cpu" {}
variable "memory" {}

variable "app_container_image" {}
variable "app_container_port" {
  default = "1337"
}
variable "app_cpu" {}
variable "app_memory" {}
variable "app_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "sidecar_container_image" {}
variable "sidecar_container_port" {
  default = "1337"
}
variable "sidecar_cpu" {}
variable "sidecar_memory" {}
variable "sidecar_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "aws_region" {}

variable "ebs_host_path" {}
variable "ebs_container_path" {}

variable "efs_host_path" {}
variable "efs_container_path" {}

