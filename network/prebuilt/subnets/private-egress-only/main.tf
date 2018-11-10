module "subnets" {
  source = "../../../modules/subnets"
  name = "${var.name}"

  vpc_id = "${var.vpc_id}"

  az_count = "${var.az_count}"

  cidr_block         = "${var.cidr_block}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits}"
}

resource "aws_route" "route" {
  route_table_id = "${module.subnets.route_table_id}"

  egress_only_gateway_id      = "${aws_egress_only_internet_gateway.gw.id}"
  destination_ipv6_cidr_block = "::/0"
}

resource "aws_egress_only_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"
}