output "arn" {
  value = "${aws_ecs_task_definition.task.arn}"
}

output "role_name" {
  value = "${module.iam_role.name}"
}

output "container_name" {
  value = "${local.container_name}"
}

output "container_port" {
  value = "${var.container_port}"
}
