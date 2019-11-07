resource "aws_iam_role" "task_role" {
  name               = "${var.task_name}_task_role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_ecs_role.json}"
}

data "aws_iam_policy_document" "assume_ecs_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "execution_role" {
  name               = "${var.task_name}_execution_role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_ecs_role.json}"
}

resource "aws_iam_role_policy" "execution_role_policy" {
  role   = "${aws_iam_role.execution_role.name}"
  policy = "${data.aws_iam_policy_document.task_execution_role.json}"
}

data "aws_iam_policy_document" "task_execution_role" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
}
