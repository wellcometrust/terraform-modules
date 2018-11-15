locals {
  vpc_cidr_block = "10.120.0.0/16"
  namespace      = "ecsV2"
  aws_region     = "eu-west-1"

  cidr_block_public  = "10.120.1.0/23"
  cidr_block_private = "10.120.2.0/23"
}

resource "aws_ecs_cluster" "cluster" {
  name = "ecsV2"
}

module "network" {
  source     = "../../../network/prebuilt/vpc/public-private-igw"
  name       = "ecsV2"

  cidr_block = "${local.vpc_cidr_block}"

  az_count   = "1"

  cidr_block_vpc = "${local.vpc_cidr_block}"

  cidr_block_public = "${local.cidr_block_public}"
  cidrsubnet_newbits_private = "0"

  cidr_block_private = "${local.cidr_block_private}"
  cidrsubnet_newbits_public = "0"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}
