variable "aws_iam_user_name" {
    type = string
    description = "Name of IAM user."
}


variable "aws_iam_user_path" {
    type = string
    description = "Path of IAM user."
}

variable "owner_tag" {
    type = string
    description = "Value that will be tagged as OWNER, on all AWS resources"
}

variable "environment_tag" {
    type = string
    description = "Value that will be tagged as ENVIRONMENT, on all AWS resources"
}

variable "prefix_tag" {
    type = string
    description = "Prefix string added to Name tag"
}