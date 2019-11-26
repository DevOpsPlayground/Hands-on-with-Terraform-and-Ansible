resource "aws_iam_access_key" "aws_user_access_key" {
  user    = var.aws_iam_user_name
}