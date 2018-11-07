
resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"
}

resource "aws_api_gateway_stage" "stage" {
  stage_name = "${var.stage_name}"
  rest_api_id = "${var.api_id}"
  deployment_id = "${aws_api_gateway_deployment.stage.id}"

  variables = "${var.variables}"
}

data "aws_acm_certificate" "certificate" {
  domain   = "${var.cert_domain_name}"
  statuses = ["ISSUED"]
}

resource "aws_api_gateway_domain_name" "stage" {
  domain_name = "${var.domain_name}"

  regional_certificate_arn = "${data.aws_acm_certificate.certificate.arn}"

  endpoint_configuration = {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "stage" {
  api_id      = "${var.api_id}"
  stage_name  = "${aws_api_gateway_deployment.stage.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.stage.domain_name}"
}
