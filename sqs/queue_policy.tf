data "aws_iam_policy_document" "write_to_queue" {
  statement {
    sid    = "es-sns-to-sqs-policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
    ]

    resources = var.topic_arns

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = var.topic_arns
    }
  }
}

data "aws_iam_policy_document" "read_from_queue" {
  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
    ]

    resources = [
      "${aws_sqs_queue.q.arn}",
    ]
  }
}
