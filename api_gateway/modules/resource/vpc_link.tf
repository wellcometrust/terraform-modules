resource "aws_api_gateway_vpc_link" "link" {
  name        = "${var.namespace}_vpc_link"
  target_arns = ["${var.target_arns}"]
}