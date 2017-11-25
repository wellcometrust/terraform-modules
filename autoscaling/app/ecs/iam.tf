data "aws_iam_policy_document" "ecs_autoscale_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_autoscale_policy" {
  statement {
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "cloudwatch:DescribeAlarms",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "ecs_autoscale_role" {
  name = "${var.name}_ecsAutoscaleRole"

  assume_role_policy = "${data.aws_iam_policy_document.ecs_autoscale_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
  name = "${var.name}_ecsAutoscaleRole_policy"

  role   = "${aws_iam_role.ecs_autoscale_role.id}"
  policy = "${data.aws_iam_policy_document.ecs_autoscale_policy.json}"
}
