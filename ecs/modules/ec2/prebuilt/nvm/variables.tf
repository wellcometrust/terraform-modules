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

variable "subnets" {
  type = "list"
}

variable "vpc_id" {}

variable "image_id" {
  default = "ami-0627e141ce928067c"
}

variable "instance_type" {
  default = "i3.2xlarge"
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

variable "nvm_host_path" {
  default = "/nvm"
}

variable "nvm_volume_id" {
  default = "/dev/nvme0n1"
}
