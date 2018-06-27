variable "cluster_name" {}

variable "asg_name" {
  description = "Name of the ASG"
}

variable "subnets" {
  type = "list"
}

variable "vpc_id" {}
variable "key_name" {}

variable "image_id" {
  default = "ami-c91624b0"
}

variable "controlled_access_cidr_ingress" {
  type        = "list"
  default     = []
  description = "CIDR for SSH access to EC2 instances"
}

variable "custom_security_groups" {
  type    = "list"
  default = []
}

variable "ssh_ingress_security_groups" {
  type    = "list"
  default = []
}

variable "spot_price" {}
