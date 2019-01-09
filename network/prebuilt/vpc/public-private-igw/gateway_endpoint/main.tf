variable "service" {}
variable "vpc_id" {}

data "aws_vpc_endpoint_service" "service" {
  service = "${var.service}"
}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id       = "${var.vpc_id}"
  service_name = "${data.aws_vpc_endpoint_service.service.service_name}"
}
