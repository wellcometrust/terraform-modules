resource "aws_iam_role" "ecs_service" {
  name               = "${var.service_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_ecs_role.json}"
}

data "aws_iam_policy_document" "assume_ecs_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "ecs_service" {
  name   = "${var.service_name}"
  role   = "${aws_iam_role.ecs_service.name}"
  policy = "${data.aws_iam_policy_document.ecs_service.json}"
}

data "aws_iam_policy_document" "ecs_service" {
  statement {
    actions = [
      # By default, we use task networking, so every task gets a
      # network interface.
      "ec2:AttachNetworkInterface",

      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:Describe*",
      "ec2:DetachNetworkInterface",

      # These are needed for service discovery (which uses Route53).
      "route53:ChangeResourceRecordSets",

      "route53:CreateHealthCheck",
      "route53:DeleteHealthCheck",
      "route53:Get*",
      "route53:List*",
      "route53:UpdateHealthCheck",
      "servicediscovery:DeregisterInstance",
      "servicediscovery:Get*",
      "servicediscovery:List*",
      "servicediscovery:RegisterInstance",
      "servicediscovery:UpdateInstanceCustomHealthStatus",
    ]

    # TODO: Can we scope this more tightly?
    resources = [
      "*",
    ]
  }
}
