data "aws_iam_policy_document" "dynamodb_update_policy" {
  statement {
    actions = [
      "dynamodb:UpdateItem",
      "dynamodb:PutItem",
    ]

    resources = [
      "${aws_dynamodb_table.table.arn}",
    ]
  }
}
