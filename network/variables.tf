variable "cidr_block" {
  description = "CIDR block for VPC"
}

variable "cidr_block_bits" {
  default = "8"
}

variable "az_count" {
  description = "Number of AZs to use"
}

variable "name" {
  description = "Name to use on resource tags"
}

variable "public_access" {
  default = true
}