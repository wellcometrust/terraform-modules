resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "${var.stage_name}"
  rest_api_id   = "${var.api_id}"
  deployment_id = "${aws_api_gateway_deployment.stage.id}"

  variables = "${var.variables}"
}

resource "aws_api_gateway_base_path_mapping" "stage" {
  api_id      = "${var.api_id}"
  stage_name  = "${aws_api_gateway_deployment.stage.stage_name}"
  domain_name = "${var.domain_name}"
  base_path   = "${var.base_path}"
}
