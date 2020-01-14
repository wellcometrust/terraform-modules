variable "name" {
  description = "Name of the SNS topic"
}

variable "cross_account_subscription_ids" {
  type        = "list"
  default     = []
  description = "AWS account IDs alolowed to subscribe to this topic"
}

variable "cross_account_publication_ids" {
  type        = "list"
  default     = []
  description = "AWS account IDs allowed to publish to this topic"
}
