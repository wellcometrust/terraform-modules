resource "aws_autoscaling_policy" "policy" {
  name = "${var.name}-scale(${var.scaling_adjustment})"

  scaling_adjustment = "${var.scaling_adjustment}"
  adjustment_type    = "ChangeInCapacity"

  cooldown = "${var.cooldown}"

  autoscaling_group_name = "${var.scalegroup_name}"
}
