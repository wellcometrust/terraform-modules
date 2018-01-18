variable "table_name" {
  description = "Name of the DynamoDB table to auto scale"
}

variable "enable_read_scaling" {
  description = "Whether to enable auto scaling for read capacity"
  default     = false
}

variable "read_target_utilization" {
  description = "Target utilization percent for read capacity"
  default     = ""
}

variable "read_min_capacity" {
  description = "Minimum provisioned read capacity"
  default     = ""
}

variable "read_max_capacity" {
  description = "Maximum provisioned read capacity"
  default     = ""
}

variable "enable_write_scaling" {
  description = "Whether to enable auto scaling for write capacity"
  default     = false
}

variable "write_target_utilization" {
  description = "Target utilization percent for write capacity"
  default     = ""
}

variable "write_min_capacity" {
  description = "Minimum provisioned write capacity"
  default     = ""
}

variable "write_max_capacity" {
  description = "Maximum provisioned write capacity"
  default     = ""
}
