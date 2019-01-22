resource "aws_iam_user" "user" {
  name = "${var.username}"
}

resource "aws_iam_user_login_profile" "user" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_access_key" "access_key" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy" "sts" {
  user   = "${aws_iam_user.user.name}"
  policy = "${data.aws_iam_policy_document.sts.json}"
}

resource "aws_iam_user_policy" "mfa" {
  user   = "${aws_iam_user.user.name}"
  policy = "${data.aws_iam_policy_document.mfa.json}"
}

resource "aws_iam_user_policy" "deny_no_mfa" {
  user   = "${aws_iam_user.user.name}"
  policy = "${data.aws_iam_policy_document.deny_no_mfa.json}"
}

data "aws_iam_policy_document" "mfa" {
  "statement" {
    effect = "Allow"

    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
    ]

    resources = ["*"]
  }

  "statement" {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/${aws_iam_user.user.name}",
    ]
  }

  "statement" {
    effect = "Allow"

    actions = [
      "iam:ListMFADevices",
    ]

    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/${aws_iam_user.user.name}",
    ]
  }

  "statement" {
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/${aws_iam_user.user.name}",
      "arn:aws:iam::*:user/${aws_iam_user.user.name}",
    ]
  }

  "statement" {
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/${aws_iam_user.user.name}",
      "arn:aws:iam::*:user/${aws_iam_user.user.name}",
    ]

    condition {
      test     = "Bool"
      values   = ["true"]
      variable = "aws:MultiFactorAuthPresent"
    }
  }
}

data "aws_iam_policy_document" "deny_no_mfa" {
  "statement" {
    effect = "Deny"

    not_actions = [
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:CreateVirtualMFADevice",
      "iam:ListVirtualMFADevices",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListSSHPublicKeys",
      "iam:ListAccessKeys",
      "iam:ListServiceSpecificCredentials",
      "iam:ListMFADevices",
      "iam:GetAccountSummary",
      "sts:*"
    ]

    resources = [
      "*"]

    condition {
      test = "BoolIfExists"
      values = [
        "false"]
      variable = "aws:MultiFactorAuthPresent"
    }
  }
}

data "aws_iam_policy_document" "sts" {
  "statement" {
    effect = "Allow"
    actions   = ["sts:*"]
    resources = ["*"]
  }
}