module "subnets" {
  source = "../../../modules/subnets"
  name = "${var.name}"

  vpc_id = "${var.vpc_id}"

  map_public_ips_on_launch = "true"

  az_count = "${var.az_count}"

  cidr_block         = "${var.cidr_block}"
  cidrsubnet_newbits = "${var.cidrsubnet_newbits}"
}

resource "aws_route" "route" {
  route_table_id = "${module.subnets.route_table_id}"

  gateway_id = "${aws_internet_gateway.gw.id}"

  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}