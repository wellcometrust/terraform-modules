data "aws_iam_policy_document" "dev_user" {
  statement {
    actions = [
      "*",
    ]

    resources = [
      "*",
    ]
  }
}
