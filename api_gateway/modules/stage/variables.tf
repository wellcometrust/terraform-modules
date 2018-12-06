variable "api_id" {}


variable "api_name" {
}

variable "alarm_topic_arn" {
  default = ""
}
variable "variables" {
  type    = "map"
  default = {}
}

variable "depends_on" {
  type = "list"
}

variable "stage_name" {}
