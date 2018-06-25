resource "aws_security_group" "ssh_controlled_ingress" {
  description = "${var.asg_name}: SSH access to instances"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "full_egress" {
  description = "${var.asg_name}: Direct access to instances"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
