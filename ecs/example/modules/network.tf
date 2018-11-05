locals {
  vpc_cidr_block = "10.120.0.0/16"
  namespace      = "ecsV2"
  aws_region     = "eu-west-1"
}

resource "aws_ecs_cluster" "cluster" {
  name = "ecsV2"
}

module "network" {
  source     = "../../../network"
  name       = "ecsV2"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "2"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}
