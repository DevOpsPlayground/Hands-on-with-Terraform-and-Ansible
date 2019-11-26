output "aws_user_name" {
  description = "name of AWS IAM user"
  value = "${aws_iam_user.iam_user.name}"
}