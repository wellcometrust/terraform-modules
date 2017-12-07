output "cluster_name" {
  value = "${aws_ecs_cluster.cluster.name}"
}

output "alb_cloudwatch_id" {
  value = "${module.cluster_alb.cloudwatch_id}"
}

output "alb_listener_https_arn" {
  value = "${module.cluster_alb.listener_https_arn}"
}

output "alb_listener_http_arn" {
  value = "${module.cluster_alb.listener_http_arn}"
}