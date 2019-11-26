resource "aws_iam_user" "iam_user" {
    
  name = var.aws_iam_user_name
  path = var.aws_iam_user_path


  tags = {
    Name = "${var.prefix_tag}_IAM_USER"
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }

}