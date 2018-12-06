output "role_name" {
  value = "${aws_iam_role.ecs_service.name}"
}

output "role_arn" {
  value = "${aws_iam_role.ecs_service.arn}"
}
