variable "service" {}
variable "vpc_id" {}

variable "security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

data "aws_vpc_endpoint_service" "service" {
  service = "${var.service}"
}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id            = "${var.vpc_id}"
  vpc_endpoint_type = "Interface"

  security_group_ids = ["${var.security_group_ids}"]

  subnet_ids = ["${var.subnet_ids}"]

  service_name = "${data.aws_vpc_endpoint_service.service.service_name}"
}
