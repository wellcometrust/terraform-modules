locals {
  default_healthcheck_path  = "/management/healthcheck"
  fallback_healthcheck_path = "${replace(var.path_pattern, "/*", local.default_healthcheck_path)}"
  healthcheck_path          = "${var.healthcheck_path == "" ? local.fallback_healthcheck_path : var.healthcheck_path}"
}

module "service" {
  source              = "ecs_service"
  service_name        = "${var.name}"
  cluster_id          = "${var.cluster_id}"
  task_definition_arn = "${module.task.arn}"
  vpc_id              = "${var.vpc_id}"
  container_name      = "${var.primary_container_name}"
  container_port      = "${var.primary_container_port}"
  listener_https_arn  = "${var.listener_https_arn}"
  listener_http_arn   = "${var.listener_http_arn}"
  path_pattern        = "${var.path_pattern}"
  alb_priority        = "${var.alb_priority}"
  desired_count       = "${var.desired_count}"
  healthcheck_path    = "${local.healthcheck_path}"
  infra_bucket        = "${var.infra_bucket}"
  host_name           = "${var.host_name}"

  client_error_alarm_topic_arn = "${var.client_error_alarm_topic_arn}"
  server_error_alarm_topic_arn = "${var.server_error_alarm_topic_arn}"
  loadbalancer_cloudwatch_id   = "${var.loadbalancer_cloudwatch_id}"

  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  enable_alb_alarm = "${var.enable_alb_alarm}"
}

module "task" {
  source           = "ecs_task"
  name             = "${var.name}"

  volume_name      = "${var.volume_name}"
  volume_host_path = "${var.volume_host_path}"

  app_uri          = "${var.app_uri}"
  nginx_uri        = "${var.nginx_uri}"

  template_name    = "${var.template_name}"
  cpu              = "${var.cpu}"
  memory           = "${var.memory}"

  primary_container_port   = "${var.primary_container_port}"
  secondary_container_port = "${var.secondary_container_port}"
  container_path           = "${var.container_path}"

  service_vars = [
    "{ \"name\" : \"INFRA_BUCKET\", \"value\" : \"${var.infra_bucket}\" }",
    "{ \"name\" : \"CONFIG_KEY\", \"value\" : \"${var.config_key}\" }",
    "{ \"name\" : \"HTTPS_DOMAIN\", \"value\" : \"${var.https_domain}\" }",
    "{ \"name\" : \"APP_PORT\", \"value\" : \"${var.secondary_container_port}\" }",
    "{ \"name\" : \"NGINX_PORT\", \"value\" : \"${var.primary_container_port}\" }",
  ]

  extra_vars            = "${var.extra_vars}"
  log_group_name_prefix = "${var.log_group_name_prefix}"
}