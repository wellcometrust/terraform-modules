variable "service_name" {}

variable "security_group_ids" {
  type = "list"
}

variable "cluster_name" {}
variable "vpc_id" {}

variable "subnets" {
  type = "list"
}

variable "namespace_id" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "app_container_image" {}
variable "app_container_port" {}
variable "sidecar_container_image" {}
variable "sidecar_container_port" {}

variable "app_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
}

variable "app_env_vars_length" {}

variable "sidecar_env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
}

variable "sidecar_env_vars_length" {}

variable "command" {
  type    = "list"
  default = []
}

variable "cpu" {
  default = "1024"
}

variable "memory" {
  default = "2048"
}

variable "app_cpu" {
  default = "512"
}

variable "app_memory" {
  default = "1024"
}

variable "sidecar_cpu" {
  default = "512"
}

variable "sidecar_memory" {
  default = "1024"
}

variable "launch_type" {
  default = "FARGATE"
}

variable "target_group_protocol" {}

variable "service_egress_security_group_id" {}

variable "target_container" {
  description = "Container to point load balancer at (can be 'app' or 'sidecar')"
  default     = "app"
}

variable "lb_arn" {}
variable "listener_port" {}

variable "task_desired_count" {
  default = "1"
}
