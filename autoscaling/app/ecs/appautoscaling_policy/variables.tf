variable "name" {}
variable "cluster_name" {}
variable "service_name" {}
variable "scaling_adjustment" {}

variable "depends_on" {
  default = []

  type = "list"
}
