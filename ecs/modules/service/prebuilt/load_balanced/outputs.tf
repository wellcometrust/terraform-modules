output "service_name" {
  value = "${aws_ecs_service.service.name}"
}

output "target_group_name" {
  value = "${replace(var.service_name, "_", "-")}"
}