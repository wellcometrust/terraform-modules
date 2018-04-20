variable "cluster_name" {
  description = "Name of cluster to run in"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "efs_filesystem_id" {
  description = "If the userdata requires an EFS mount point, this is it"
  default     = "no_name_set"
}

variable "ebs_block_device" {
  default = "no_name_set"
}

variable "cache_cleaner_cloudwatch_log_group" {
  default = ""
}

variable "ebs_cache_max_age_days" {
  default = ""
}

variable "ebs_cache_max_size" {
  default = ""
}

variable "log_group_name_prefix" {
  description = "Cloudwatch log group name prexix"
  default     = "platform"
}

variable "log_retention_in_days" {
  description = "The number of days to keep CloudWatch logs"
  default     = ""
}
