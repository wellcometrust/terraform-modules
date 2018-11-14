resource "aws_ecs_cluster" "cluster" {
  name = "${local.namespace}"
}

module "network" {
  source     = "../../network/prebuilt/vpc/public-private-igw"
  name       = "${local.namespace}"

  az_count   = "1"

  cidr_block_public = "172.42.0.0/23"
  cidrsubnet_newbits_public = "1"

  cidr_block_private = "172.43.0.0/23"
  cidrsubnet_newbits_private = "1"

  cidr_block_vpc = "${local.vpc_cidr_block}"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}
