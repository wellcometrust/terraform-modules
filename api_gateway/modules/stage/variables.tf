variable "api_id" {}

variable "variables" {
  type    = "map"
  default = {}
}

variable "depends_on" {
  type = "list"
}

variable "stage_name" {}

variable "cache_enabled" {
  default = "false"
}

variable "cache_size" {
  default = "1.6"
}

variable "cache_ttl_in_seconds" {
  default = "60"
}