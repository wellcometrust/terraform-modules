data "aws_availability_zones" "zones" {}

resource "aws_subnet" "subnet" {
  count = "${var.az_count}"

  cidr_block = "${cidrsubnet(var.cidr_block, var.cidrsubnet_newbits, count.index)}"

  availability_zone = "${data.aws_availability_zones.zones.names[(count.index % (data.aws_availability_zones.zones.count + 1))]}"
  vpc_id            = "${var.vpc_id}"

  map_public_ip_on_launch = "${var.map_public_ips_on_launch}"

  tags {
    Name = "${var.name}-${data.aws_availability_zones.zones.names[(count.index % (data.aws_availability_zones.zones.count + 1))]}-${count.index}"
  }
}

resource "aws_route_table" "table" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table_association" "network" {
  count          = "${var.az_count}"
  subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.table.id}"
}
