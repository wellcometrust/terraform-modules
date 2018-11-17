resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"

  variables {
    "depends" = "${md5(join(",", var.depends_on))}"
  }
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "${var.stage_name}"
  rest_api_id   = "${var.api_id}"
  deployment_id = "${aws_api_gateway_deployment.stage.id}"

  variables = "${var.variables}"
}

locals {
  base_bath_mappings ="${var.stage_name == "" ? 1 : 0}"
}

resource "aws_api_gateway_base_path_mapping" "stage" {
  count = "${local.base_bath_mappings}"

  api_id      = "${var.api_id}"
  stage_name  = "${aws_api_gateway_deployment.stage.stage_name}"
  domain_name = "${var.domain_name}"
  base_path   = "${var.base_path}"
}