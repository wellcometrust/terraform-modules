resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block_vpc}"

  assign_generated_ipv6_cidr_block = true
}

module "public_subnets" {
  source = "../../subnets/public-igw"
  name = "${var.name}-public"

  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block         = "${var.cidr_block_public}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits_public}"

  az_count = "${var.az_count}"
}

module "private_subnets" {
  source = "../../subnets/private-egress-only"
  name = "${var.name}-private"

  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block         = "${var.cidr_block_private}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits_private}"

  az_count = "${var.az_count}"
}