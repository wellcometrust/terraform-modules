output "id" {
  value = "${aws_iam_access_key.access_key.id}"
}

output "secret" {
  value = "${aws_iam_access_key.access_key.encrypted_secret}"
}

output "arn" {
  value = "${aws_iam_user.terraform_root.arn}"
}
