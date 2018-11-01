output "arn" {
  description = "ARN of the Lambda function"
  value       = "${aws_lambda_function.lambda_function.arn}"
}

output "function_name" {
  description = "Name of the Lambda function"
  value       = "${aws_lambda_function.lambda_function.function_name}"
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = "${aws_lambda_function.lambda_function.invoke_arn}"
}