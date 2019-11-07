variable "api_id" {}

variable "variables" {
  type    = "map"
  default = {}
}

variable "dependencies" {
  type = "list"
}

variable "stage_name" {}
