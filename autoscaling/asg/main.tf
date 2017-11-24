module "scale_up" {
  source = "./autoscaling_policy"
  name   = "${var.name}-scale-up"

  scalegroup_name    = "${var.scalegroup_name}"
  scaling_adjustment = "${var.scale_up_adjustment}"
}

module "scale_down" {
  source = "./autoscaling_policy"
  name   = "${var.name}-scale-down"

  scalegroup_name    = "${var.scalegroup_name}"
  scaling_adjustment = "${var.scale_down_adjustment}"
}
