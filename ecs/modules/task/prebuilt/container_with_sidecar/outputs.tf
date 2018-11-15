output "task_definition_arn" {
  value = "${module.task_definition.task_definition_arn}"
}

output "task_role_name" {
  value = "${module.task_definition.task_role_name}"
}

output "app_task_name" {
  value = "${module.container_definition.app_container_name}"
}

output "sidecar_task_name" {
  value = "${module.container_definition.sidecar_container_name}"
}

output "app_task_port" {
  value = "${var.app_container_port}"
}

output "sidecar_task_port" {
  value = "${var.sidecar_container_port}"
}
