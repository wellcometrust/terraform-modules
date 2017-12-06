data "aws_iam_role" "task_role" {
  name = "${var.task_role_name}"
}

resource "aws_iam_role_policy" "read_config_from_s3" {
  name   = "${var.name}_read_config_from_s3"
  role   = "${data.aws_iam_role.task_role.arn}"
  policy = "${data.aws_iam_policy_document.allow_config_read.json}"
}

data "aws_iam_policy_document" "allow_config_read" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      "arn:aws:s3:::${var.infra_bucket}/${var.config_key}",
    ]
  }
}
