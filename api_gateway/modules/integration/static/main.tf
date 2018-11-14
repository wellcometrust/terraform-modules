resource "aws_api_gateway_integration" "resource_s3_integration" {
  rest_api_id             = "${var.api_id}"
  resource_id             = "${var.resource_id}"
  http_method             = "${var.http_method}"
  integration_http_method = "GET"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.aws_region}:s3:path//${var.bucket_name}/${var.s3_key}"

  credentials             = "${var.static_resource_role_arn}"
}