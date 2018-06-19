variable "key_name" {}
variable "vpc_id" {}

variable "hashed_password" {
  default = "sha1:5310f21e370d:a4d66e725c179218638c21c03d83933aa066db2d"
}

variable "bucket_name" {}

variable "vpc_subnets" {
  type = "list"
}

variable "name" {}

variable "enabled" {
  default = false
}

variable image_id {
  # Ubuntu DLAMI
  default = "ami-0bc19972"
}

variable "instance_type" {
  default = "t2.large"
}

variable "default_environment" {}
variable "spot_price" {}

variable "subnet_list" {
  type = "list"
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
