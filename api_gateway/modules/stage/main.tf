resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"

  description = "${md5(join(",", var.depends_on))}"
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "${var.stage_name}"
  rest_api_id   = "${var.api_id}"
  deployment_id = "${aws_api_gateway_deployment.stage.id}"
  cache_cluster_enabled = "${var.cache_enabled}"
  cache_cluster_size = "${var.cache_size}"
  variables = "${var.variables}"
}

resource "aws_api_gateway_method_settings" "s" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"
  method_path = "*/*"

  settings {
    caching_enabled = "${var.cache_enabled}"
  cache_ttl_in_seconds = "${var.cache_ttl_in_seconds}"
  }
}