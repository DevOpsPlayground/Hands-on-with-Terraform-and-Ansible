variable "aws_iam_user_name" {
    type = string
    description = "Name of IAM user policy will be attached to."
}

variable "aws_iam_policy_name" {
    type = string
    description = "Name of IAM policy."
}

variable "aws_iam_policy_file" {
    type = string
    description = "Path of Json file containing IAM User policy."
}