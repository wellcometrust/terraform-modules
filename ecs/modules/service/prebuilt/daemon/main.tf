resource "aws_ecs_service" "service" {
  name            = "${var.service_name}_daemon"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${var.task_definition_arn}"

  launch_type         = "EC2"
  scheduling_strategy = "DAEMON"

  deployment_minimum_healthy_percent = "0"
  deployment_maximum_percent         = "100"

  network_configuration = {
    subnets          = ["${var.subnets}"]
    security_groups  = ["${var.security_group_ids}"]
    assign_public_ip = false
  }
}
