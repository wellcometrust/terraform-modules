variable "name" {
  description = "Name of the EFS mount"
}

variable "subnets" {
  type        = "list"
  description = "subnets where to create the EFS mount"
}

variable "vpc_id" {
  description = "ID of VPC to to create EFS mount in"
}

variable "efs_access_security_group_ids" {
  type        = "list"
  description = "IDs of the security groups of the EC2 instances that need to access the EFS"
}

variable "performance_mode" {
  description = "EFS Performance mode (generalPurpose or maxIO)"
  default     = "generalPurpose"
}

variable "num_subnets" {
  description = "Number of subnets"
}
