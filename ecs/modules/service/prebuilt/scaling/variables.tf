variable "min_capacity" {
  default = 0
}

variable "max_capacity" {
  default = 3
}

variable "vpc_id" {}

variable "cluster_id" {}
variable "cluster_name" {}

variable "service_name" {}

variable "subnets" {
  type = "list"
}

variable "launch_type" {
  default = "FARGATE"
}

variable "task_desired_count" {
  default = 1
}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "task_definition_arn" {}

variable "namespace_id" {
  default = "ecs"
}
