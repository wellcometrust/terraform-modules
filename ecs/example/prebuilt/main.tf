module "example_rest_service" {
  source = "../../prebuilt/rest"

  service_name    = "example_rest_service"
  container_image = "strm/helloworld-http"

  namespace_id = "${local.namespace_id}"
  cluster_name = "${local.cluster_id}"
  vpc_id       = "${local.vpc_id}"

  subnets = "${local.private_subnets}"

  container_port = "80"

  env_vars        = {}
  env_vars_length = 0

  security_group_ids = [
    "${aws_security_group.interservice_security_group.id}",
    "${aws_security_group.service_lb_security_group.id}",
  ]

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"

  target_group_listener_arn = "${aws_alb_listener.http_80.arn}"
}

module "example_scaling_service" {
  source = "../../prebuilt/scaling"

  service_name    = "example_scaling_service"
  container_image = "strm/helloworld-http"

  namespace_id = "${local.namespace_id}"
  cluster_name = "${local.cluster_id}"
  vpc_id       = "${local.vpc_id}"

  subnets = "${local.private_subnets}"

  container_port = "80"

  env_vars        = {}
  env_vars_length = 0

  security_group_ids = [
    "${aws_security_group.interservice_security_group.id}",
    "${aws_security_group.service_lb_security_group.id}",
  ]

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"

  metric_namespace = "MyCustomMetric"
  high_metric_name = "SomeValue"
  low_metric_name  = "SomeOtherValue"
}
