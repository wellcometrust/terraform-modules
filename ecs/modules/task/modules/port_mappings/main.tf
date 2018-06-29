variable "container_port" {}

variable "host_port" {
  default = "0"
}

variable "expose_port" {
  default = "false"
}

variable "protocol" {
  description = "Valid values are 'tcp' or 'udp'"
  default     = "tcp"
}

locals {
  host_port = "${var.host_port == "0" ? var.container_port : var.host_port}"

  port_mapping_with_host = {
    ContainerPort = "${var.container_port}"
    HostPort      = "${local.host_port}"
    Protocol      = "${var.protocol}"
  }
  port_mapping_with_host_string = "[${replace(jsonencode(local.port_mapping_with_host), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}]"

  port_mapping_without_host = {
    ContainerPort = "${var.container_port}"
    Protocol      = "${var.protocol}"
  }
  port_mapping_without_host_string = "[${replace(jsonencode(local.port_mapping_without_host), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}]"

  port_mapping_string = "${var.expose_port == "false" ? local.port_mapping_without_host_string : local.port_mapping_with_host_string}"
}

output "port_mappings_string" {
  value = "${local.port_mapping_string}"
}

output "container_port" {
  value = "${var.container_port}"
}

output "host_port" {
  value = "${var.host_port}"
}

output "protocol" {
  value = "${var.protocol}"
}
