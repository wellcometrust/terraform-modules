variable "name" {
  description = "Name of the ECS cluster to create"
}

variable "key_name" {
  description = "SSH key pair name for instance sign-in"
}

variable "admin_cidr_ingress" {
  default     = "0.0.0.0/0"
  description = "CIDR for SSH access to EC2 instances"
}

variable "asg_on_demand_min" {
  default = "0"
}

variable "asg_on_demand_desired" {
  default = "0"
}

variable "asg_on_demand_max" {
  default = "1"
}

variable "asg_on_demand_instance_type" {
  default = "m4.xlarge"
}

variable "asg_spot_min" {
  default = "1"
}

variable "asg_spot_desired" {
  default = "2"
}

variable "asg_spot_max" {
  default = "4"
}

variable "asg_spot_instance_type" {
  default = "m4.xlarge"
}

variable "asg_spot_price" {
  default = "0.1"
}

variable "vpc_id" {}

variable "vpc_subnets" {
  type = "list"
}

variable "alb_certificate_domain" {}

variable "alb_log_bucket_id" {}

variable "ec2_terminating_topic_arn" {}
variable "ec2_terminating_topic_publish_policy" {}
variable "ec2_instance_terminating_for_too_long_alarm_arn" {}

variable "instance_security_groups" {
  description = "Security groups to add to the launch config for the ASG"
  type        = "list"
  default     = []
}
