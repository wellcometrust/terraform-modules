module "example_rest_service" {
  source = "../../prebuilt/rest"

  service_name = "example_rest_service"
  container_image = "strm/helloworld-http"

  namespace_id = "${local.namespace_id}"
  cluster_id   = "${local.cluster_id}"
  vpc_id       = "${local.vpc_id}"

  private_subnets = "${local.private_subnets}"

  container_port = "80"

  env_vars = {}
  env_vars_length = 0

  security_group_ids = [
    "${aws_security_group.interservice_security_group.id}",
    "${aws_security_group.service_lb_security_group.id}"
  ]

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"
}