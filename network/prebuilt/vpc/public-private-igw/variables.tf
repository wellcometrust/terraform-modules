variable "name" {}

variable "cidr_block_vpc" {}

variable "cidr_block_public" {}
variable "cidr_block_private" {}

variable "cidrsubnet_newbits_public" {}
variable "cidrsubnet_newbits_private" {}

variable "public_az_count" {
  default = "4"
}

variable "private_az_count" {
  default = "4"
}
