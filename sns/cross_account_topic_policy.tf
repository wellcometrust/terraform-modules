data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  has_cross_account_subs = "${length(var.cross_account_subscription_ids) > 0}"
  has_cross_account_pubs = "${length(var.cross_account_publication_ids) > 0}"

  cross_account_pub_and_sub        = "${local.has_cross_account_subs && local.has_cross_account_pubs}"
  cross_account_publications_only  = "${local.has_cross_account_pubs && !local.has_cross_account_subs}"
  cross_account_subscriptions_only = "${local.has_cross_account_subs && !local.has_cross_account_pubs}"
}

resource "aws_sns_topic_policy" "cross_account_topic_pub_and_sub_policy" {
  count  = "${local.cross_account_pub_and_sub ? 1 : 0}"
  arn    = "${aws_sns_topic.topic.arn}"
  policy = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_pub_and_sub.json}"
}

resource "aws_sns_topic_policy" "cross_account_topic_publications_only_policy" {
  count  = "${local.cross_account_publications_only ? 1 : 0}"
  arn    = "${aws_sns_topic.topic.arn}"
  policy = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_publications.json}"
}

resource "aws_sns_topic_policy" "cross_account_topic_subscriptions_only_policy" {
  count  = "${local.cross_account_subscriptions_only ? 1 : 0}"
  arn    = "${aws_sns_topic.topic.arn}"
  policy = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_subscriptions.json}"
}

data "aws_iam_policy_document" "cross_account_sns_topic_policy_source" {
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
}

data "aws_iam_policy_document" "cross_account_sns_topic_policy_subscriptions" {
  source_json = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_source.json}"

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

data "aws_iam_policy_document" "cross_account_sns_topic_policy_publications" {
  source_json = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_source.json}"

  statement {
    effect = "Allow"

    actions = [
      "SNS:GetTopicAttributes",
      "SNS:Publish",
    ]

    principals {
      type        = "AWS"
      identifiers = "${formatlist("arn:aws:iam::%s:root", var.cross_account_publication_ids)}"
    }

    resources = [
      "${aws_sns_topic.topic.arn}",
    ]

    sid = "PublishAccess"
  }

  statement {
    effect = "Allow"

    actions = [
      "SNS:GetTopicAttributes",
      "SNS:Publish",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.topic.arn}",
    ]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"
      values   = ["${formatlist("arn:aws:cloudwatch:%s:%s:alarm:*", data.aws_region.current.name, var.cross_account_publication_ids)}"]
    }

    sid = "PublishAlarmAccess"
  }
}

data "aws_iam_policy_document" "cross_account_sns_topic_policy_pub_and_sub" {
  source_json   = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_subscriptions.json}"
  override_json = "${data.aws_iam_policy_document.cross_account_sns_topic_policy_publications.json}"

  statement {
    sid = "PublishAccess"
  }

  statement {
    sid = "ReportingAccess"
  }
}
