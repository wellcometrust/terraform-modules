module "aws_totalinstances_high" {
  source = "./asg_totalinstances_alarm"
  name   = "${var.name}-aws_totalinstances_high"

  asg_name = "${var.asg_name}"

  period    = "${var.high_period}"
  threshold = "${var.high_threshold}"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "${var.treat_missing_data_high}"

  target_arn = "${var.scale_up_arn}"
}

module "aws_totalinstances_low" {
  source = "./asg_totalinstances_alarm"
  name   = "${var.name}-aws_totalinstances_low"

  asg_name = "${var.asg_name}"

  period    = "${var.low_period}"
  threshold = "${var.low_threshold}"

  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "${var.treat_missing_data_low}"

  target_arn = "${var.scale_down_arn}"
}
