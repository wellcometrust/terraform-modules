variable "cluster_name" {}

variable "asg_name" {
  description = "Name of the ASG"
}

variable "asg_min" {
  description = "Minimum number of instances"
  default     = "1"
}

variable "asg_desired" {
  description = "Desired number of instances"
  default     = "1"
}

variable "asg_max" {
  description = "Max number of instances"
  default     = "2"
}

variable "instance_type" {
  default     = "t2.small"
  description = "AWS instance type"
}

variable "subnets" {
  type = "list"
}

variable "vpc_id" {}

variable "image_id" {
  default = "ami-c91624b0"
}

variable "key_name" {
  description = "SSH key name for SSH access.  Leave blank if not using SSH."
  default     = ""
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
