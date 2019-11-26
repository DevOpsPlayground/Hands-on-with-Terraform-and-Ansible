output "aws_user_key_id" {
  description = "Access key ID for aws_core_user"
  value = "${aws_iam_access_key.aws_user_access_key.id}"
}

output "aws_user_key_secret" {
  description = "Secret Access key for aws_core_user"
  value = "${aws_iam_access_key.aws_user_access_key.secret}"
}