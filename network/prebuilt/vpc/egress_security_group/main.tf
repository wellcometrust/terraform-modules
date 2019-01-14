resource "aws_security_group" "security_group" {
  name        = "${var.name}_egress"
  description = "Allows all egress traffic from the group"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}"
  }
}

module "vpc_endpoints" {
  source = "../interface_endpoints"

  vpc_id            = "${var.vpc_id}"
  security_group_id = "${aws_security_group.security_group.id}"
  subnet_ids        = "${var.subnet_ids}"
}
