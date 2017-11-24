variable "name" {}
variable "scalegroup_name" {}
variable "scale_up_adjustment" {
  default = 1
}
variable "scale_down_adjustment" {
  default = -1
}
