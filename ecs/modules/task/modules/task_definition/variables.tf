variable "task_definition_template_path" {
  description = "A custom task definition template to use"
  default     = ""
}

variable "aws_region" {
  description = "AWS Region the task will run in"
}

variable "log_group_name" {}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "container_image" {}
variable "container_name" {}
variable "container_port" {}

variable "env_var_string" {}

variable "cpu" {}
variable "memory" {}

variable "mount_points" {
  type    = "list"
  default = []
}
