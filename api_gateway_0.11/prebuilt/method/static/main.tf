module "method" {
  source = "../../../modules/method"

  http_method = "${var.http_method}"

  api_id      = "${var.api_id}"
  resource_id = "${var.resource_id}"
}

module "static_integration" {
  source = "../../../modules/integration/static"

  resource_id = "${var.resource_id}"

  aws_region  = "${var.aws_region}"
  bucket_name = "${var.bucket_name}"
  s3_key      = "${var.s3_key}"

  api_id      = "${var.api_id}"
  http_method = "${module.method.http_method}"

  static_resource_role_arn = "${var.static_resource_role_arn}"
}

resource "aws_api_gateway_method_response" "http_200" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${module.method.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "http_200" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${module.method.http_method}"
  status_code = "${aws_api_gateway_method_response.http_200.status_code}"
}
