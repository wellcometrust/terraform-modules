variable "api_id" {}

variable "variables" {
  type    = "map"
  default = {}
}

variable "depends_on" {
  type = "list"
}

variable "stage_name" {}
