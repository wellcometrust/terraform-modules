module "example_rest_service" {
  source = "../../ecs/prebuilt/rest"

  service_name    = "example_rest_service"
  container_image = "strm/helloworld-http"

  namespace_id = "${local.namespace_id}"
  cluster_name = "${local.cluster_id}"
  vpc_id       = "${local.vpc_id}"

  subnets = "${local.subnets}"

  container_port = "${local.internal_port}"

  env_vars        = {}
  env_vars_length = 0

  security_group_ids = [
    "${aws_security_group.interservice_security_group.id}",
    "${aws_security_group.service_lb_ingress_security_group.id}",
  ]

  target_group_protocol = "TCP"

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"

  target_group_listener_arn = "${aws_lb_listener.tcp.arn}"
}
