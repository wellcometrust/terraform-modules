data "aws_caller_identity" "current" {}

resource "aws_sns_topic_policy" "cross_account_topic_subscription_policy" {
  count  = "${length(var.cross_account_subscription_ids) > 0 ? 1 : 0}"
  arn    = "${aws_sns_topic.topic.arn}"
  policy = "${data.aws_iam_policy_document.cross_account_sns_topic_policy.json}"
}

data "aws_iam_policy_document" "cross_account_sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${data.aws_caller_identity.current.account_id}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.topic.arn}",
    ]

    sid = "__default_statement_ID"
  }

  statement {
    effect = "Allow"

    actions = [
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Receive",
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
    ]

    principals {
      type        = "AWS"
      identifiers = "${formatlist("arn:aws:iam::%s:root", var.cross_account_subscription_ids)}"
    }

    resources = [
      "${aws_sns_topic.topic.arn}",
    ]

    sid = "ReportingAccess"
  }
}
