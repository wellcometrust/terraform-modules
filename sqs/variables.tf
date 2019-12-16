variable "queue_name" {
  description = "Name of the SQS queue to create"
}

variable "topic_count" {
  default = "1"
}

variable "topic_arns" {
  type        = "list"
  description = "Topic name for the SNS topic to subscribe the queue to"
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue"
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds that SQS retains a message"
  default     = 345600
}

variable "max_message_size" {
  description = "Maximum message size allowed by SQS, in bytes"
  default     = 262144
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed"
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning"
  default     = 0
}

variable "max_receive_count" {
  description = "Max receive count before sending to DLQ"
  default     = "4"
}

variable "alarm_topic_arn" {
  description = "ARN of the topic where to send notification for DLQs not being empty"
}
