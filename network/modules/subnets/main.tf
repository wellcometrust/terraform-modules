data "aws_availability_zones" "zones" {}

locals {
  availability = "${var.map_public_ips_on_launch == true ? "public" : "private"}"

  az_count = "${length(data.aws_availability_zones.zones.names)}"
  az_names = "${data.aws_availability_zones.zones.names}"

  subnet_count = "${var.az_count == "" ? local.az_count : var.az_count}"
}

resource "aws_subnet" "subnet" {
  count = "${local.subnet_count}"

  cidr_block = "${cidrsubnet(var.cidr_block, var.cidrsubnet_newbits, count.index)}"

  availability_zone = "${local.az_names[(count.index % (local.az_count + 1))]}"
  vpc_id            = "${var.vpc_id}"

  map_public_ip_on_launch = "${var.map_public_ips_on_launch}"

  tags {
    Name         = "${var.name}-${local.az_names[(count.index % (local.az_count + 1))]}-${count.index}"
    Availability = "${local.availability}"
  }
}

resource "aws_route_table" "table" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table_association" "network" {
  count          = "${local.subnet_count}"
  subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.table.id}"
}
