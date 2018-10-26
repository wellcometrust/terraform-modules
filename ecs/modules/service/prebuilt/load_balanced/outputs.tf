output "service_name" {
  value = "${aws_ecs_service.service.name}"
}

output "target_group_arn" {
  value = "${var.target_group_protocol == "HTTP"? aws_alb_target_group.http_target_group.arn : aws_alb_target_group.tcp_target_group.arn}"
}

output "target_group_arn_suffix" {
  value = "${var.target_group_protocol == "HTTP"? aws_alb_target_group.http_target_group.arn_suffix : aws_alb_target_group.tcp_target_group.arn_suffix}"
}
