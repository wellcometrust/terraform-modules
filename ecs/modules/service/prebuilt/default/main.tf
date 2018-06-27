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
