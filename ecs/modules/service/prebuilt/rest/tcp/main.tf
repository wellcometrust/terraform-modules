module "iam" {
  source = "../../../modules/iam"

  service_name = "${var.service_name}"
}

module "service_discovery" {
  source = "../../../modules/service_discovery"

  namespace_id = "${var.namespace_id}"
  service_name = "${var.service_name}"
}

module "target_group" {
  source = "../../../modules/target_group/tcp"

  service_name = "${var.service_name}"

  vpc_id = "${var.vpc_id}"
  lb_arn = "${var.lb_arn}"

  listener_port  = "${var.listener_port}"
  container_port = "${var.container_port}"
}

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
    assign_public_ip = "${var.assign_public_ip}"
  }

  service_registries {
    registry_arn = "${module.service_discovery.arn}"
  }

  load_balancer {
    target_group_arn = "${module.target_group.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }
}
