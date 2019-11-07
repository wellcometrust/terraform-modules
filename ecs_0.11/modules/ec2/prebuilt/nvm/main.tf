module "asg" {
  source = "../../../../../ec2/prebuilt/ondemand"

  name = "${var.asg_name}"

  image_id = "${var.image_id}"

  controlled_access_cidr_ingress = ["${var.controlled_access_cidr_ingress}"]

  custom_security_groups      = ["${var.custom_security_groups}"]
  ssh_ingress_security_groups = ["${var.ssh_ingress_security_groups}"]

  subnet_list = ["${var.subnets}"]
  vpc_id      = "${var.vpc_id}"
  key_name    = "${var.key_name}"
  user_data   = "${data.template_file.userdata.rendered}"

  asg_max     = "${var.asg_max}"
  asg_desired = "${var.asg_desired}"
  asg_min     = "${var.asg_min}"

  instance_type = "${var.instance_type}"
}

data "template_file" "userdata" {
  template = "${file("${path.module}/../../modules/userdata/nvm.tpl")}"

  vars {
    cluster_name  = "${var.cluster_name}"
    nvm_host_path = "${var.nvm_host_path}"
    nvm_volume_id = "${var.nvm_volume_id}"
  }
}

module "instance_policy" {
  source = "../../modules/instance_role_policy"

  cluster_name               = "${var.cluster_name}"
  instance_profile_role_name = "${module.asg.instance_profile_role_name}"
}
