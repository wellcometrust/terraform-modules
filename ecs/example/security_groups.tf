resource "aws_security_group" "efs_security_group" {
  name        = "efs_security_group"
  description = "Allow traffic between services and efs"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${local.namespace}-efs"
  }
}

resource "aws_security_group" "service_egress_security_group" {
  name        = "service_egress_security_group"
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
  name        = "interservice_security_group"
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

resource "aws_security_group" "service_lb_security_group" {
  name        = "service_lb_security_group"
  description = "Allow traffic between services and load balancer"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    self      = true
  }

  ingress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${local.namespace}-service-lb"
  }
}

resource "aws_security_group" "external_lb_security_group" {
  name        = "external_lb_security_group"
  description = "Allow traffic between load balancer and internet"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${local.namespace}-external-lb"
  }
}
