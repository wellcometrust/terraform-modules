variable "domain_name" {}
variable "api_id" {}
variable "stage_name" {}
variable "variables" {
  type = "map"
  default = {}
}
variable "cert_domain_name" {}
