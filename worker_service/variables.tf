variable "name" {
  description = "The name of this worker service"
}

variable "cluster_name" {
  description = "The name of the cluster in which this service is deployed."
}

variable "vpc_id" {
  description = "The id of the VPC in which the worker service runs."
}

variable "ingest_topic_name" {
  description = "The name of the SNS topic to subscribe the ingest queue to."
}

variable "dlq_alarm_arn" {
  description = "Alarm of the ARN which the ingest DLQ should alert on."
}

variable "listener_https_arn" {
  description = "HTTPS listener ARN from ALB"
}

variable "listener_http_arn" {
  description = "HTTP listener ARN from ALB"
}

variable "infra_bucket" {
  description = "The name of the S3 bucket used to store infrastructure config."
}

variable "loadbalancer_cloudwatch_id" {
  description = "Cloudwatch ID for the ALB."
}

variable "alb_server_error_alarm_arn" {
  description = "Alarm of the ARN used to report server errors."
}

variable "alb_client_error_alarm_arn" {
  description = "Alarm of the ARN used to report client errors."
}

variable "https_domain" {
  description = "HTTPS domain the ALB is running in."
}

variable "config_vars" {
  description = "Variables for the config template"
  type        = "map"
  default     = {}
}

variable "alb_priority" {
  description = "ALB priority for service"
  default     = "100"
}

variable "service_cpu" {
  description = "CPU to provide task"
  default     = 256
}

variable "service_memory" {
  description = "Memory to provide task"
  default     = 1024
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "release_id" {
  description = "The specific release of the worker service to deploy."
  default     = "latest"
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum % of tasks running"
  default     = "0"
}

variable "deployment_maximum_percent" {
  description = "Maximum % of tasks running"
  default     = "200"
}

variable "build_env" {
  description = "The build environment (used to find config in infra_bucket)."
  default     = "prod"
}

variable "app_container_repo_uri" {
  description = "ECR repository URL"
}