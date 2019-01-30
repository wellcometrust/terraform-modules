locals {
  vpc_cidr_block = "10.120.0.0/16"
  namespace      = "ecs-example"
  aws_region     = "eu-west-1"

  cidr_block_public  = "10.120.1.0/23"
  cidr_block_private = "10.120.2.0/23"
}

resource "aws_ecs_cluster" "cluster" {
  name = "ecsV2"
}

module "network" {
  source = "../../../network/prebuilt/vpc/public-private-igw"
  name   = "${local.namespace}"

  cidr_block_vpc = "172.17.0.0/24"

  cidr_block_public         = "172.17.0.0/25"
  cidrsubnet_newbits_public = "3"

  cidr_block_private         = "172.17.0.128/25"
  cidrsubnet_newbits_private = "3"

  public_az_count  = "3"
  private_az_count = "3"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}
