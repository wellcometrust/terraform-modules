output "id" {
  value = "${aws_api_gateway_integration.resource_s3_integration.id}"
}

output "uri" {
  value = "${aws_api_gateway_integration.resource_s3_integration.uri}"
}