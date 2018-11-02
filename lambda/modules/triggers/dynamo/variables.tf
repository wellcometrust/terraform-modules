variable "stream_arn" {
  description = "ARN of the DynamoDB stream"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to be triggered"
}

variable "function_role" {
  description = "Name of the IAM role for the AWS Lambda"
}

variable "batch_size" {
  description = "Maximum batch size to retrieve from the stream"
  default     = 1
}

variable "starting_position" {
  description = "Position in the stream where AWS Lambda should start reading"
  default     = "LATEST"
}
