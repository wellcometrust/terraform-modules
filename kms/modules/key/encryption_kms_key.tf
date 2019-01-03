resource "aws_kms_key" "encryption_key" {
  policy = "${data.aws_iam_policy_document.enable_kms_iam.json}"
}
