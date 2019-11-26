variable "aws_region" {
  description = "AWS region to use."
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "190.168.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for Subnet."
  type        = string
  default     = "190.168.10.0/24"
}

variable "aws_availability_zone" {
  description = "AWS availability zone to place the subnet."
  type        = string
  default     = "ap-southeast-1a"
}

variable "additional_cidrs" {
  description = "Additional CIDR blocks that will be allowed access to the PG instance."
  type        = list
  default     = ["127.0.0.1/32"]
}

variable "own_tag" {
  description = "Owner tag added to all AWS resources."
  type        = string
}

variable "env_tag" {
  description = "Value for ENVIRONMENT tag that is applied to all AWS instances."
  type        = string
  default     = "PLAYGROUND"
}

variable "pre_tag" {
  description = "Descriptor prefixed to NAME tag on all AWS resources."
  type        = string
  default     = "TERRAFORM"
}

variable "pub_key_file" {
  description = "Name of public key files that exists locally under ~/.ssh"
  type        = string
}

variable "pub_key_name" {
  description = "Name of keypair created in AWS."
  type        = string
  default     = "TERRAFORM"
}

variable "server_count" {
  description = "Number of playground instances to create."
  type        = string
  default     = "1"
}

variable "private_key_file" {
  description = "Name of private key file under ~/.ssh"
  type        = string
}

