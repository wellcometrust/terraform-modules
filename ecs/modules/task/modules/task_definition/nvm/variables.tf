variable "task_name" {}

variable "memory" {
  description = "How much memory to allocate to the app"
  default     = 1024
}

variable "cpu" {
  description = "How much CPU to allocate to the app"
  default     = 512
}

variable "task_definition_rendered" {}

variable "nvm_host_path" {
  default = "/nvm"
}

variable "nvm_container_path" {
  default = "/tmp"
}
