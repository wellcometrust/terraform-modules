locals {
  vpc_cidr_block = "10.77.0.0/16"
  namespace      = "ecsV3"
  aws_region     = "eu-west-1"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"
  cluster_id   = "${aws_ecs_cluster.cluster.id}"
  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  private_subnets = "${module.network.private_subnets}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.namespace}"
}

module "network" {
  source     = "../../../network"
  name       = "${local.namespace}"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "2"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}
