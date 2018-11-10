variable "api_id" {}
variable "resource_id" {}

variable "http_method" {}

variable "integration_method" {
  default = "ANY"
}

variable "connection_id" {}

variable "forward_port" {}

variable "forward_path" {}

variable "hostname" {}

variable "proxy" {
  default = true
}

variable "request_parameters" {
  type    = "map"
  default = {}
}
