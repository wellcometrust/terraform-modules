data "aws_iam_policy_document" "ecs_autoscale_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_autoscale_role" {
  name = "ecsAutoscaleRole"

  assume_role_policy = "${data.aws_iam_policy_document.ecs_autoscale_policy.json}"
}

resource "aws_iam_policy_attachment" "ecs_autoscale_role_attach" {
  name = "ecs-autoscale-role-attach"

  roles = [
    "${aws_iam_role.ecs_autoscale_role.name}",
  ]

  # Managed policy: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_managed_policies.html#AmazonEC2ContainerServiceAutoscaleRole
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
