output "task_definition_arn" {
  value = "${module.task_definition.task_definition_arn}"
}

output "task_role_name" {
  value = "${module.task_definition.task_role_name}"
}

output "task_name" {
  value = "${module.container_definition.container_name}"
}

output "task_port" {
  value = "${var.container_port}"
}
