variable "name" {
  description = "Name of the ASG to create"
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

variable "subnet_list" {
  type = "list"
}

variable "instance_type" {
  default     = "t2.small"
  description = "AWS instance type"
}

variable "key_name" {
  description = "SSH key pair name for instance sign-in"
}

variable "user_data" {
  description = "User data for ec2 container hosts"
  default     = ""
}

variable "public_ip" {
  description = "Associate public IP address?"
  default     = true
}

variable "vpc_id" {
  description = "VPC for EC2 autoscaling group security group"
}

variable "random_key" {
  default = "initial"
}

variable "image_id" {
  description = "ID of the AMI to use on the instances"
}

variable "use_spot" {
  default = 0
}

variable "spot_price" {
  default = "0"
}

variable "admin_cidr_ingress" {
  type        = "list"
  default     = ["0.0.0.0/0"]
  description = "CIDR for SSH access to EC2 instances"
}

variable "instance_security_groups" {
  type    = "list"
  default = []
}
