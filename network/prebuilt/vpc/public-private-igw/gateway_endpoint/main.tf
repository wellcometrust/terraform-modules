variable "service" {}
variable "vpc_id" {}
variable "route_table_id" {}

data "aws_vpc_endpoint_service" "service" {
  service = "${var.service}"
}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id          = "${var.vpc_id}"
  service_name    = "${data.aws_vpc_endpoint_service.service.service_name}"
  route_table_ids = ["${var.route_table_id}"]
}
