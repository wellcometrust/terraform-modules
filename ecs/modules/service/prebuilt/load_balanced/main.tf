resource "aws_ecs_service" "http_tg_service" {
  count           = "${var.target_group_protocol == "HTTP"? 1: 0}"
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
    target_group_arn = "${aws_alb_target_group.http_target_group.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }

  depends_on = ["data.aws_lb_listener.listener"]
}

resource "aws_ecs_service" "tcp_tg_service" {
  count           = "${var.target_group_protocol == "TCP"? 1: 0}"
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
    target_group_arn = "${aws_lb_target_group.tcp_target_group.arn}"
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

resource "aws_alb_target_group" "http_target_group" {
  count = "${var.target_group_protocol == "HTTP"? 1: 0}"

  # We use snake case in a lot of places, but ALB Target Group names can
  # only contain alphanumerics and hyphens.
  name = "${local.target_group_name}"

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

resource "aws_lb_target_group" "tcp_target_group" {
  count = "${var.target_group_protocol == "TCP"? 1: 0}"

  # We use snake case in a lot of places, but ALB Target Group names can
  # only contain alphanumerics and hyphens.
  name = "${local.target_group_name}"

  target_type = "ip"

  protocol = "TCP"
  port     = "${var.container_port}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }
}
