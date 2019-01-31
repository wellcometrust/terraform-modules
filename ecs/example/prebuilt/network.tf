locals {
  vpc_cidr_block = "172.16.0.0/23"
  namespace      = "ecs-example"
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
  source = "../../../network/prebuilt/vpc/public-private-igw"

  name = "${local.namespace}"

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
