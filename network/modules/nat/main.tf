resource "aws_eip" "nat" {
  vpc = true

  tags {
    Name = "${var.name}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${var.subnet_id}"

  tags {
    Name = "${var.name}-${var.subnet_id}"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}
