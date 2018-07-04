variable "service_name" {}
variable "ecs_cluster_id" {}
variable "task_definition_arn" {}

variable "vpc_id" {}

variable "subnets" {
  type = "list"
}

variable "security_group_ids" {
  type    = "list"
  default = []
}
