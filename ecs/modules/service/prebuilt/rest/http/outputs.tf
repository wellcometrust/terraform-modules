output "name" {
  value = "${aws_ecs_service.service.name}"
}

output "target_group_arn" {
  value = "${module.target_group.arn}"
}
