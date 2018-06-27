output "task_definition_arn" {
  value = "${aws_ecs_task_definition.task.arn}"
}

output "container_name" {
  value = "${var.container_name}"
}

output "container_port" {
  value = "${var.container_port}"
}

output "task_role_name" {
  value = "${module.iam_roles.name}"
}
