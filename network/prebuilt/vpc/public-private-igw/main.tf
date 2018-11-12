resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block_vpc}"
}

module "public_subnets" {
  source = "../../subnets/public-igw"
  name   = "${var.name}-public"

  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block         = "${var.cidr_block_public}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits_public}"

  az_count = "${var.az_count}"
}

module "private_subnets" {
  source = "../../../modules/subnets"
  name   = "${var.name}-private"

  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block         = "${var.cidr_block_private}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits_private}"

  az_count = "${var.az_count}"
}

module "nat" {
  source = "../../../modules/nat"
  name   = "${var.name}"

  vpc_id = "${aws_vpc.vpc.id}"

  subnet_id      = "${module.public_subnets.subnets[0]}"
  route_table_id = "${module.private_subnets.route_table_id}"
}
