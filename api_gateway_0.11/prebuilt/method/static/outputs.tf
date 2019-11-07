output "http_method" {
  value = "${module.method.http_method}"
}

output "integration_id" {
  value = "${module.static_integration.id}"
}

output "integration_response_resource_id" {
  value = "${aws_api_gateway_integration_response.http_200.resource_id}"
}
