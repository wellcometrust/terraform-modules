variable "vpc_id" {
  description = "VPC for EC2 autoscaling group security group"
}

variable "asg_name" {
  description = "Name of the ASG to create"
}

variable "key_name" {
  description = "SSH key pair name for instance sign-in"
}

variable "image_id" {
  description = "ID of the AMI to use on the instances"
}

variable "instance_type" {
  description = "AWS instance type"
}

variable "instance_profile_name" {
  description = "Instance profile for ec2 container hosts"
}

variable "user_data" {
  description = "User data for ec2 container hosts"
  default     = ""
}

variable "public_ip" {
  description = "Associate public IP address?"
}

variable "controlled_access_cidr_ingress" {
  type        = "list"
  default     = []
  description = "CIDR for SSH access to EC2 instances"
}

variable "ssh_ingress_security_groups" {
  type    = "list"
  default = []
  description = "SSH ingresss security group"
}

# variable "instance_security_groups" {
#   type        = "list"
#   description = "A list of the security groups to apply to an instance."
# }

variable "use_spot" {}
variable "spot_price" {}
