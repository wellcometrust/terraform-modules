resource "aws_security_group" "service_egress_security_group" {
  name        = "${local.namespace}-service_egress_security_group"
  description = "Allow traffic between services"
  vpc_id      = "${module.network.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${local.namespace}-egress"
  }
}

resource "aws_security_group" "interservice_security_group" {
  name        = "${local.namespace}-interservice_security_group"
  description = "Allow traffic between services"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags {
    Name = "${local.namespace}-interservice"
  }
}
