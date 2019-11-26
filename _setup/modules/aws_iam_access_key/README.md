# AWS IAM Access Key

## Introduction

Use this module to create an access key and secret key for a given user. 

## Resources Created

* Access key ID
* Secret Access key

## How to reference

In your terraform script:

```

module "aws_iam_access_key" {
  source = "git::github.ecs-digital.co.uk:Terraform-Modules/aws_iam_access_key.git"

# VARIABLE DEFINITION

}
```

## Notes

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_iam\_user\_name | Name of IAM user. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_user\_key\_id | Access key ID for aws_core_user |
| aws\_user\_key\_secret | Secret Access key for aws_core_user |