terraform {
  required_version = ">= 0.12.16"
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # Canonical

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


resource "aws_key_pair" "aws_core_keypair" {
    key_name   = "PLAYGROUND_${var.my_full_name}"
    public_key = file("~/.ssh/playground.pub")
}

//Terraform resources

resource "aws_instance" "aws_simple_instance" {

  ami                    = data.aws_ami.amazon_linux.id
  count                  = var.simple_instance_count_var
  instance_type          = "t2.micro"
  subnet_id              = var.aws_subnet_id
  vpc_security_group_ids = ["${var.aws_default_sg_id}"]
  key_name               = aws_key_pair.aws_core_keypair.key_name

  tags = {
    Name = "PLAYGROUND_SERVER_${var.my_full_name}"
  }

}

output "playground_url" {
  description = "URL of your instance(s)"
  value = "${formatlist("http://%s",aws_instance.aws_simple_instance.*.public_ip)}"
}

//Terraform Variables

variable "simple_instance_count_var" {
  description = "Number of instances to create"
  type        = string
  default     = "1"
}

variable "aws_subnet_id" {
  description = "The id of the subnet"
  type        = string
}

variable "my_full_name" {
  description = "Your full name no spaces."
  type        = string
}

variable "aws_default_sg_id" {
  description = "The id of the default security group"
  type        = string
}

// Terraform Output
output "simple_public_ip" {
  description = "Public ip of the instance"
  value       = "${aws_instance.aws_simple_instance.*.public_ip}"
}

output "simple_private_ip" {
  description = "Private ip of the instance"
  value       = "${aws_instance.aws_simple_instance.*.private_ip}"
}