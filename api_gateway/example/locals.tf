locals {
  vpc_cidr_block = "10.78.0.0/16"
  namespace      = "api-gw-example"
  aws_region     = "eu-west-1"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"
  cluster_id   = "${aws_ecs_cluster.cluster.id}"
  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  nlb_listener_port       = "80"
  nlb_listener_port_stage = "8080"

  container_port = "80"

  external_path = "example"

  scope_name = "example"
  scope_id   = "${aws_cognito_resource_server.api.identifier}/${local.scope_name}"

  subnets = "${module.network.private_subnets}"
}
