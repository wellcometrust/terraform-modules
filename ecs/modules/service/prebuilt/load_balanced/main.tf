resource "aws_ecs_service" "service" {
  name            = "${var.service_name}"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${var.task_definition_arn}"
  desired_count   = "${var.task_desired_count}"

  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  launch_type = "${var.launch_type}"

  network_configuration = {
    subnets          = ["${var.subnets}"]
    security_groups  = ["${var.security_group_ids}"]
    assign_public_ip = false
  }

  service_registries {
    registry_arn = "${aws_service_discovery_service.service_discovery.arn}"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.ecs_service.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }
}

resource "aws_service_discovery_service" "service_discovery" {
  name = "${var.service_name}"

  health_check_custom_config {
    failure_threshold = "${var.service_discovery_failure_threshold}"
  }

  dns_config {
    namespace_id = "${var.namespace_id}"

    dns_records {
      ttl  = 5
      type = "A"
    }
  }
}

resource "aws_alb_target_group" "ecs_service" {
  # We use snake case in a lot of places, but ALB Target Group names can
  # only contain alphanumerics and hyphens.
  name = "${replace(var.service_name, "_", "-")}"

  target_type = "ip"

  protocol = "HTTP"
  port     = "${var.container_port}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "HTTP"
    path     = "${var.healthcheck_path}"
    matcher  = "200"
  }
}

module "alb_alarm" {
  source = "alb_alarm"
  # The rule here is: if we have less than the minimum percent of
  # healthy hosts, we should alarm.
  #
  # If this is zero (i.e. it's okay to go down to no running hosts), we don't
  # alarm --- this is not an uptime-critical service.
  enable_alarm = "${ceil(local.healthy_host_threshold) > 0 && var.enable_alb_alarm ? 1 : 0}"
  tg_dimension = "${aws_alb_target_group.ecs_service.arn_suffix}"
  lb_dimension = "${var.loadbalancer_cloudwatch_id}"
  name   = "${var.service_name}-alb-not-enough-healthy-hosts"
  comparison_operator = "LessThanThreshold"
  metric              = "HealthyHostCount"
  topic_arn           = "${var.server_error_alarm_topic_arn}"

  threshold = "${local.healthy_host_threshold}"

  # There have been scenarios where HealthyHostCount doesn't report any data
  # (e.g. when an invalid container definition was pushed).  In this case,
  # we still want an alarm!  So if we don't have data, assume something is up.
  treat_missing_data = "breaching"
}