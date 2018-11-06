variable "api_id" {}

variable "api_root_resource_id" {}

variable "resource_name" {}

variable "proxied_hostname" {}

variable "forward_port" {}
variable "forward_path" {}

variable "target_arns" {
  type = "list"
}

variable "namespace" {}
