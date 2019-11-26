variable "aws_core_vpc_cidr" {
    type = string
    description = "VPC CIDR block for the AWS Core VPC"
}

variable "aws_core_subnet_cidr1" {
    type = string
    description = "CIDR block for first subnet of AWS Core network"
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

variable "aws_core_az_1" {
    type = string
    description = "Availability zone for first subnet of AWS core network"
}

variable "additional_public_cidrs" {
    type = list
    description = "List of additional cidrs that need to be added to ingress rules. In format 1.2.3.4/32"
}