# AWS IAM User

## Introduction

Use this module to create an IAM user in AWS 

## Resources Created

* IAM User

## How to reference

In your terraform script:

```

module "aws_iam_user" {
  source = "git::github.ecs-digital.co.uk:Terraform-Modules/aws_iam_user.git"

# VARIABLE DEFINITION

}
```

## Notes

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_ami\_id | AMI ID of AWS servers to create. | string | n/a | yes |
| aws\_instance\_count | Number of AWS servers to create. | string | n/a | yes |
| aws\_instance\_type | Instance type of AWS server. | string | n/a | yes |
| aws\_keypair\_name | Name of aws keypair for AWS server. | string | n/a | yes |
| aws\_sg\_id | Security Group ID for AWS server. | string | n/a | yes |
| aws\_subnet1\_id | Subnet1 ID for AWS server. | string | n/a | yes |
| aws\_volume\_size | EBS block size of AWS server | string | n/a | yes |
| environment\_tag | Value that will be tagged as ENVIRONMENT, on all AWS resources | string | n/a | yes |
| owner\_tag | Value that will be tagged as OWNER, on all AWS resources | string | n/a | yes |
| prefix\_tag | Prefix string added to Name tag | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ips | Public IPs of aws instance(s) |