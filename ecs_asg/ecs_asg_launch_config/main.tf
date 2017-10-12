resource "aws_launch_configuration" "ondemand_launch_config" {
  count = "${var.use_spot == true ? 0 : "${var.ebs_device_name == "" ? 1 : 0}" }"

  security_groups = [
    "${aws_security_group.instance_sg.id}",
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
    "${aws_security_group.instance_sg.id}",
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

resource "aws_launch_configuration" "ebs_launch_config" {
  count = "${var.ebs_device_name == "" || var.ebs_volume_type == "io1" ? 0 : 1}"

  security_groups = [
    "${aws_security_group.instance_sg.id}",
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

  ebs_block_device {
    volume_size = "${var.ebs_size}"
    device_name = "${var.ebs_device_name}"
    volume_type = "${var.ebs_volume_type}"
  }
}

resource "aws_launch_configuration" "ebs_io1_launch_config" {
  count = "${var.ebs_device_name != "" && var.ebs_volume_type == "io1" && var.root_ebs_iops == false  ? 1 : 0}"

  security_groups = [
    "${aws_security_group.instance_sg.id}",
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

  ebs_block_device {
    volume_size = "${var.ebs_size}"
    device_name = "${var.ebs_device_name}"
    volume_type = "${var.ebs_volume_type}"
    iops        = "${var.ebs_iops}"
  }
}

resource "aws_launch_configuration" "ebs_io1_root_iops_launch_config" {
  count = "${var.ebs_device_name != "" && var.ebs_volume_type == "io1" && var.root_ebs_iops == "true" ? 1 : 0}"

  security_groups = [
    "${aws_security_group.instance_sg.id}",
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

  root_block_device {
    volume_size = 10
    volume_type = "io1"
    iops = 500
  }

  ebs_block_device {
    volume_size = "${var.ebs_size}"
    device_name = "${var.ebs_device_name}"
    volume_type = "${var.ebs_volume_type}"
    iops        = "${var.ebs_iops}"
  }
}
