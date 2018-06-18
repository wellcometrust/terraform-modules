variable "name" {
  description = "Name of the task to create"
}

variable "template_name" {
  description = "Name of the template to use"
  default     = "default"
}

variable "task_definition_template_path" {
  description = "A custom task definition template to use"
  default     = ""
}

variable "nginx_uri" {
  description = "URI of container image for nginx"
  default     = "wellcome/nginx:latest"
}

variable "app_uri" {
  description = "URI of container image for app"
}

variable "aws_region" {
  description = "AWS Region the task will run in"
  default     = "eu-west-1"
}

variable "volume_name" {
  description = "Name of volume to mount (if required)"
  default     = "ephemera"
}

variable "volume_host_path" {
  description = "Location of mount point on host path (if required)"
  default     = "/tmp"
}

variable "primary_container_port" {
  description = "Port exposed by the primary container"
  default     = ""
}

variable "secondary_container_port" {
  description = "Port exposed by the secondary container"
  default     = ""
}

variable "container_path" {
  description = "Path of the mounted volume in the docker container"
  default     = ""
}

variable "service_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
}

variable "config_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
}

variable "config_vars_length" {
  description = "[Deprecated] Length of the config_vars map"
  default     = 0
}

variable "memory" {
  description = "How much memory to allocate to the app"
}

variable "cpu" {
  description = "How much CPU to allocate to the app"
}

variable "log_group_name_prefix" {
  description = "Cloudwatch log group name prexix"
}

variable "log_retention_in_days" {
  description = "The number of days to keep CloudWatch logs"
  default     = ""
}
