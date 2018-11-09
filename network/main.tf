data "aws_availability_zones" "available" {}

locals {
  public_az_count = "${var.public_access == true ? var.az_count : 0}"
  
  egress_igw_count = "${var.public_access == true ? 0 : 1}"
  bidi_igw_count   = "${var.public_access == true ? 1 : 0}"

  gateway_id = "${var.public_access == true ? aws_internet_gateway.gw-bidi.id : aws_egress_only_internet_gateway.gw-egress.id}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}"
  }
}

resource "aws_egress_only_internet_gateway" "gw-egress" {
  count = "${local.egress_igw_count}"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_internet_gateway" "gw-bidi" {
  count = "${local.bidi_igw_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${local.gateway_id}"
}

# Public subnets

resource "aws_subnet" "public" {
  count             = "${local.public_az_count}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, var.cidr_block_bits, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.vpc.id}"

  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.name}-${data.aws_availability_zones.available.names[count.index]}-public"
  }
}

resource "aws_eip" "nat" {
  count      = "${var.az_count}"
  vpc        = true
  depends_on = ["aws_internet_gateway.gw"]

  tags {
    Name = "${var.name}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = "${var.az_count}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    Name = "${var.name}-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route_table" "private_route_table" {
  count  = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-${data.aws_availability_zones.available.names[count.index]}-private"
  }
}

resource "aws_route" "private_route" {
  count                  = "${var.az_count}"
  route_table_id         = "${element(aws_route_table.private_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
}

# Private subnets

resource "aws_subnet" "private" {
  count             = "${var.az_count}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, (count.index + local.public_az_count))}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-${data.aws_availability_zones.available.names[count.index]}-private"
  }
}

resource "aws_route_table_association" "network" {
  count          = "${var.az_count}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
}
