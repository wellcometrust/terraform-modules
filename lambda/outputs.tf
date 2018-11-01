output "arn" {
  description = "ARN of the Lambda function"
  value       = "${module.public_lambda_function.arn}"
}

output "function_name" {
  description = "Name of the Lambda function"
  value       = "${module.public_lambda_function.function_name}"
}

output "role_name" {
  description = "Name of the IAM role for this Lambda"
  value       = "${aws_iam_role.iam_role.name}"
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = "${module.public_lambda_function.invoke_arn}"
}
