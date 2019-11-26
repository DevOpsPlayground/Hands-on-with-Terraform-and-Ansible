# AWS User Policy

## Introduction

Use this module to create an IAM User policy in AWS. 

## Resources Created

* IAM User policy

## How to reference

In your terraform script:

```

module "aws_iam_user_policy" {
  source = "git::github.ecs-digital.co.uk:Terraform-Modules/aws_iam_user_policy.git"

# VARIABLE DEFINITION

}
```

## Notes

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_iam\_policy\_file | Path of Json file containing IAM User policy. | string | n/a | yes |
| aws\_iam\_policy\_name | Name of IAM policy. | string | n/a | yes |
| aws\_iam\_user\_name | Name of IAM user policy will be attached to. | string | n/a | yes |