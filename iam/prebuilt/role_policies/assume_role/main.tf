resource "aws_iam_role_policy" "role_assumer" {
  # count here?

  role   = "${var.role_name}"
  policy = "${data.aws_iam_policy_document.role_assumer.json}"
}

data "aws_iam_policy_document" "role_assumer" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    # hand a map with these values in and count over it?
    resources = ["${var.assumable_roles}"]
  }
}