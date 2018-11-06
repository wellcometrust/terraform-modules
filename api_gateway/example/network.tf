resource "aws_ecs_cluster" "cluster" {
  name = "${local.namespace}"
}

module "network" {
  source     = "../../network"
  name       = "${local.namespace}"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "1"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}
