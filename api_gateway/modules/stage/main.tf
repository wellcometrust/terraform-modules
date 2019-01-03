locals {
  // Add hash of dependencies to the variables block to force
  // new deployment if dependencies change
  variables = "${merge(var.variables, map("dependencies_md5", md5(join(",", var.depends_on))))}"
}

resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"

  variables = "${local.variables}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "${var.stage_name}"
  rest_api_id   = "${var.api_id}"
  deployment_id = "${aws_api_gateway_deployment.stage.id}"

  variables = "${local.variables}"
}
