module "ecs_iam" {
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs_iam?ref=v1.0.0"
  name   = "${var.name}"
}


data "aws_iam_policy_document" "read_from_q" {
  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
    ]

    resources = [
      "${var.source_queue_arn}",
    ]
  }
}

resource "aws_iam_role_policy" "ecs_task_read_q" {
  name   = "ecs_task_${var.name}_read_${var.source_queue_name}_policy"
  role   = "${module.ecs_iam.task_role_name}"
  policy = "${data.aws_iam_policy_document.read_from_q.json}"
}
