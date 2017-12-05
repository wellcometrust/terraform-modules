module "worker_service" {
  source             = "git::https://github.com/wellcometrust/terraform.git//services?ref=v1.3.1"
  name               = "${var.name}"
  cluster_id         = "${data.aws_ecs_cluster.host_cluster.id}"
  task_role_arn      = "${module.ecs_worker_service_iam.task_role_arn}"
  vpc_id             = "${var.vpc_id}"
  app_uri            = "${var.app_container_repo_uri}"
  listener_https_arn = "${var.listener_https_arn}"
  listener_http_arn  = "${var.listener_http_arn}"
  path_pattern       = "/${var.name}/*"
  alb_priority       = "${var.alb_priority}"
  infra_bucket       = "${var.infra_bucket}"

  config_key           = "config/${var.build_env}/${var.name}.ini"
  config_template_path = "config/${var.name}.ini.template"

  cpu    = "${var.service_cpu}"
  memory = "${var.service_memory}"

  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  config_vars = "${merge(local.export_topic_config, local.ingest_queue_config, local.metrics_namespace_config, var.config_vars)}"

  loadbalancer_cloudwatch_id   = "${var.loadbalancer_cloudwatch_id}"
  server_error_alarm_topic_arn = "${var.alb_server_error_alarm_arn}"
  client_error_alarm_topic_arn = "${var.alb_client_error_alarm_arn}"

  https_domain = "${var.https_domain}"
}
