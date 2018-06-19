variable "task_name" {}

variable "memory" {
  description = "How much memory to allocate to the app"
  default     = 1024
}

variable "cpu" {
  description = "How much CPU to allocate to the app"
  default     = 512
}

variable "aws_region" {
  description = "AWS Region the task will run in"
}

variable "container_name" {
  description = "Internal name of primary container"
  default     = "app"
}

variable "container_image" {
  description = "Container image to run"
}

variable "container_port" {
  description = "Port exposed by the primary container"
}

variable "env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "efs_host_path" {}
variable "efs_container_path" {}
