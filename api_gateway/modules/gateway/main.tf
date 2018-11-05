resource "aws_api_gateway_rest_api" "api" {
  name = "${var.name}"

  endpoint_configuration = {
    types = ["${var.endpoint_config_types}"]
  }
}