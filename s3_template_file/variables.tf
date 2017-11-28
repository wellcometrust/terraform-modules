variable "s3_bucket" {
  description = "Name of the S3 bucket for storing the rendered template"
}

variable "s3_key" {
  description = "Key of the S3 object which stores the rendered template"
}

variable "template_vars" {
  description = "Variables for the template file"
  type        = "map"
}

variable "template_path" {
  description = "Path to the template, relative to the current working directory"
}

variable "enabled" {
  description = "Should this module create an object in S3?"
  default     = true
}
