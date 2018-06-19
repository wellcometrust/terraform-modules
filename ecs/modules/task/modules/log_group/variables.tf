variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "log_retention_in_days" {
  description = "The number of days to keep CloudWatch logs"
  default     = 7
}

variable "task_name" {}
