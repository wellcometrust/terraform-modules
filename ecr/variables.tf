variable "id" {
  description = "ID of the ECR repository"
}

variable "namespace" {
  description = "Namespace prefix to ECR repository"
}

variable "protected" {
  description = "Protect resource from deletion"
  default     = true
}
