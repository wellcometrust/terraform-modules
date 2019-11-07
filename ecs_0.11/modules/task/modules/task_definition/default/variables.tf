variable "task_name" {}

variable "memory" {
  description = "How much memory to allocate to the app"
  default     = 1024
}

variable "cpu" {
  description = "How much CPU to allocate to the app"
  default     = 512
}

variable "launch_types" {
  type    = "list"
  default = ["FARGATE", "EC2"]
}

variable "task_definition_rendered" {}
