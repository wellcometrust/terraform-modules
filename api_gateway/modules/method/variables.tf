variable "api_id" {}

variable "http_method" {
  default = "ANY"
}

variable "request_parameters" {
  type    = "map"
  default = {}
}

variable "authorization" {
  default = ""
}

variable "authorizer_id" {
  default = "not_real"
}

variable "authorization_scopes" {
  type    = "list"
  default = []
}

variable "resource_id" {}
