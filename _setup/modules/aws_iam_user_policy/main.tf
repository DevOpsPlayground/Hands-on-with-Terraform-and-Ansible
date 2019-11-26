resource "aws_iam_user_policy" "aws_core_user_policy" {
  name = var.aws_iam_policy_name
  user = var.aws_iam_user_name

  policy = var.aws_iam_policy_file

}