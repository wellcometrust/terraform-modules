variable "name" {}

variable "cidr_block_vpc" {}

variable "cidr_block_public" {}
variable "cidr_block_private" {}

variable "cidrsubnet_newbits_public" {}
variable "cidrsubnet_newbits_private" {}

variable "az_count" {
  default = "4"
}
