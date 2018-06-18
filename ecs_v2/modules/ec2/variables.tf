variable "cluster_name" {}

variable "subnets" {
  type = "list"
}

variable "vpc_id" {}
variable "key_name" {}

variable "image_id" {
  default = "ami-c91624b0"
}
