module "asg" {
  source = "../../ec2/asg"

  name = "${var.cluster_name}"

  image_id = "${var.image_id}"

  subnet_list = ["${var.subnets}"]
  vpc_id      = "${var.vpc_id}"
  key_name    = "${var.key_name}"
  user_data   = "${data.template_file.userdata.rendered}"
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.sh.tpl")}"

  vars {
    cluster_name = "${var.cluster_name}"
  }
}

data "aws_iam_policy_document" "instance_policy" {
  statement {
    sid = "ecsInstanceRole"

    actions = [
      "ecs:StartTelemetrySession",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "instance" {
  name   = "${var.cluster_name}_instance_role_policy"
  role   = "${module.asg.instance_profile_role_name}"
  policy = "${data.aws_iam_policy_document.instance_policy.json}"
}
