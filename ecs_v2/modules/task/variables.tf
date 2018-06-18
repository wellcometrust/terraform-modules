variable "task_name" {
  description = "Name of the task to create"
}

variable "task_definition_template_path" {
  description = "A custom task definition template to use"
  default     = ""
}

variable "container_image" {
  description = "Container image to run"
}

variable "aws_region" {
  description = "AWS Region the task will run in"
}

variable "container_port" {
  description = "Port exposed by the primary container"
  default     = 80
}

variable "service_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "config_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "config_vars_length" {
  default = 0
}

variable "memory" {
  description = "How much memory to allocate to the app"
  default     = 1024
}

variable "cpu" {
  description = "How much CPU to allocate to the app"
  default     = 512
}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "log_retention_in_days" {
  description = "The number of days to keep CloudWatch logs"
  default     = 7
}
