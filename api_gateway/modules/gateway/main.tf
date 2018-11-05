resource "aws_api_gateway_rest_api" "api" {
  name = "${var.name}"

  endpoint_configuration = {
    types = ["${var.endpoint_config_types}"]
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${var.stage}"
}