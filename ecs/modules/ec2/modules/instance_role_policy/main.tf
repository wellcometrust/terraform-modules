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
  role   = "${var.instance_profile_role_name}"
  policy = "${data.aws_iam_policy_document.instance_policy.json}"
}
