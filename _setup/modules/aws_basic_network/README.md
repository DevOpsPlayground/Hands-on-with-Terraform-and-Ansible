# AWS Basic Network

## Introduction

Use this module to create a basic VPC and necessary dependencies so that you can quickly get your EC2 instances created.

## Resources Created

* VPC
* 1 x Subnet
* Internet Gateway
* Default Route Table
* Default Security Group

## How to reference

In your terraform script:

```

module "aws_basic_network" {
  source = "./modules/aws_basic_network"

# VARIABLE DEFINITION

}
```


## Notes

Security group will create ingress rules that are open to the private network and *your* ip address.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional\_public\_cidrs | List of additional cidrs that need to be added to ingress rules. In format 1.2.3.4/32 | list | n/a | yes |
| aws\_core\_az\_1 | Availability zone for first subnet of AWS core network | string | n/a | yes |
| aws\_core\_subnet\_cidr1 | CIDR block for first subnet of AWS Core network | string | n/a | yes |
| aws\_core\_vpc\_cidr | VPC CIDR block for the AWS Core VPC | string | n/a | yes |
| environment\_tag | Value that will be tagged as ENVIRONMENT, on all AWS resources | string | n/a | yes |
| owner\_tag | Value that will be tagged as OWNER, on all AWS resources | string | n/a | yes |
| prefix\_tag | Prefix string added to Name tag | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_default\_sg\_id | AWS Default Security Group ID |
| aws\_subnet\_id | AWS Subnet ID |
| aws\_vpc\_id | AWS VPC ID |