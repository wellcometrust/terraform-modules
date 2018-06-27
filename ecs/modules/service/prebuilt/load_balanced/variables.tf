variable "service_name" {}
variable "ecs_cluster_id" {}
variable "task_desired_count" {}
variable "task_definition_arn" {}

variable "subnets" {
  type = "list"
}

variable "container_name" {}
variable "container_port" {}

variable "vpc_id" {}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "deployment_minimum_healthy_percent" {
  default = "100"
}

variable "deployment_maximum_percent" {
  default = "200"
}

variable "healthcheck_path" {
  default = "/"
}

variable "launch_type" {
  default = "FARGATE"
}

variable service_discovery_failure_threshold {
  default = 1
}

variable "namespace_id" {
  default = "ecs"
}
