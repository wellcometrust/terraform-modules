output "encryption_key_arn" {
  value = "${aws_kms_key.encryption_key.arn}"
}

output "encryption_key_id" {
  value = "${aws_kms_key.encryption_key.id}"
}

output "use_encryption_key_policy" {
  value = "${data.aws_iam_policy_document.use_encryption_key.json}"
}
