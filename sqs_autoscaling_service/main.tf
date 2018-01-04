module "appautoscaling" {
  source = "../autoscaling/app/ecs"
  name   = "${var.name}"

  cluster_name = "${var.cluster_name}"
  service_name = "${module.service.service_name}"
}

module "sqs_autoscaling_alarms" {
  source = "../autoscaling/alarms/sqs"
  name   = "${var.name}"

  queue_name = "${var.source_queue_name}"

  scale_up_arn   = "${module.appautoscaling.scale_up_arn}"
  scale_down_arn = "${module.appautoscaling.scale_down_arn}"
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = "${var.cluster_name}"
}

module "service" {
  source = "../service"
  name   = "${var.name}"

  cluster_id = "${data.aws_ecs_cluster.cluster.arn}"
  vpc_id     = "${var.vpc_id}"

  app_uri = "${var.ecr_repository_url}:${var.release_id}"

  listener_https_arn = "${var.alb_listener_https_arn}"
  listener_http_arn  = "${var.alb_listener_http_arn}"

  path_pattern = "/${var.name}/*"
  alb_priority = "${var.alb_priority}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  deployment_minimum_healthy_percent = "0"
  deployment_maximum_percent         = "200"

  env_vars        = "${var.env_vars}"
  env_vars_length = "${var.env_vars_length}"

  loadbalancer_cloudwatch_id   = "${var.alb_cloudwatch_id}"
  server_error_alarm_topic_arn = "${var.alb_server_error_alarm_arn}"
  client_error_alarm_topic_arn = "${var.alb_client_error_alarm_arn}"

  https_domain = "services.wellcomecollection.org"
}
