locals {
  namespace = "${var.name}-private"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"

  assign_generated_ipv6_cidr_block = true

  tags {
    Name = "${local.namespace}"
  }
}

module "subnets" {
  source = "../../subnets/private-egress-only"
  name = "${local.namespace}"

  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block         = "${var.cidr_block}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits}"

  az_count = "${var.az_count}"
}