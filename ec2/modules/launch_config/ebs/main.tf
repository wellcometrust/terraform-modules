resource "aws_launch_configuration" "launch_config" {
  security_groups = ["${var.instance_security_groups}"]

  key_name                    = "${var.key_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_profile_name}"
  user_data                   = "${var.user_data}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

  ebs_block_device {
    volume_size = "${var.ebs_size}"
    device_name = "${var.ebs_device_name}"
    volume_type = "${var.ebs_volume_type}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
