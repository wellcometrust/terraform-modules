resource "aws_launch_configuration" "ondemand_launch_config" {
  count = "${var.use_spot == true ? 0 : 1 }"

  security_groups = [
    "${aws_security_group.full_egress.id}",
    "${aws_security_group.ssh_controlled_ingress.id}",
  ]

  key_name                    = "${var.key_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_profile_name}"
  user_data                   = "${var.user_data}"
  associate_public_ip_address = "${var.public_ip}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "spot_launch_config" {
  count      = "${var.use_spot}"
  spot_price = "${var.spot_price}"

  security_groups = [
    "${aws_security_group.full_egress.id}",
    "${aws_security_group.ssh_controlled_ingress.id}",
  ]

  key_name                    = "${var.key_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_profile_name}"
  user_data                   = "${var.user_data}"
  associate_public_ip_address = "${var.public_ip}"

  lifecycle {
    create_before_destroy = true
  }
}
