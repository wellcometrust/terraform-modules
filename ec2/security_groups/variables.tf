variable "admin_cidr_ingress" {
  type        = "list"
  default     = ["0.0.0.0/0"]
  description = "CIDR for SSH access to EC2 instances"
}
