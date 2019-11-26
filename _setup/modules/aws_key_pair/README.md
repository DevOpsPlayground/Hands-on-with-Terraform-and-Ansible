# AWS Keypair

## Introduction

Use this module to create a key pair in your AWS account. 

## Resources Created

* Keypair

## How to reference

In your terraform script:

```

module "aws_key_pair" {
  source = "./modules/aws_key_pair"

# VARIABLE DEFINITION

}
```


## Notes


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_core\_public\_key\_file | Name of public key file located under ~/.ssh | string | n/a | yes |
| aws\_core\_public\_key\_name | Name of Key pair in AWS. Ensure this name matches the key pair manually uploaded if using csp. | string | n/a | yes |
