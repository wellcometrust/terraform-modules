variable "domain_name" {}
variable "api_id" {}

variable "stage_name" {
  default = ""
}

variable "variables" {
  type    = "map"
  default = {}
}

variable "depends_on" {
  type = "list"
}

variable "base_path" {
  default = ""
}
