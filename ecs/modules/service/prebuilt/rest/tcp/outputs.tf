output "name" {
  value = "${aws_ecs_service.service.name}"
}

output "target_group_arn" {
  value = "${module.target_group.arn}"
}

output "task_role_name" {
  value = "${module.iam.role_name}"
}

output "task_role_arn" {
  value = "${module.iam.role_arn}"
}
