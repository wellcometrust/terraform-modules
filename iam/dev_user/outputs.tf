output "user_id_primary" {
  value = "${aws_iam_access_key.access_key_primary.id}"
}

output "user_secret_primary" {
  value = "${aws_iam_access_key.access_key_primary.encrypted_secret}"
}

output "user_id_secondary" {
  value = "${aws_iam_access_key.access_key_secondary.id}"
}

output "user_secret_secondary" {
  value = "${aws_iam_access_key.access_key_secondary.encrypted_secret}"
}

output "password" {
  value = "${aws_iam_user_login_profile.user.encrypted_password}"
}

output "name" {
  value = "${aws_iam_user.user.name}"
}
