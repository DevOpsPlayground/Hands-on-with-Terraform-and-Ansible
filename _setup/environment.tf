terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = var.aws_region
}

# Create a basic network for the environment. VPC, Subnet, Security groups, IGW etc
module "aws_basic_network" {
  source = "./modules/aws_basic_network"
  
  aws_core_vpc_cidr = "${var.vpc_cidr}"
  aws_core_subnet_cidr1 = "${var.subnet_cidr}"
  aws_core_az_1 = "${var.aws_availability_zone}"
  additional_public_cidrs = "${var.additional_cidrs}"

  owner_tag = "${var.own_tag}"
  environment_tag = "${var.env_tag}"
  prefix_tag = "${var.pre_tag}"
}

module "aws_key_pair" {
  source = "./modules/aws_key_pair"

  aws_core_public_key_file = "${var.pub_key_file}"
  aws_core_public_key_name = "${var.pub_key_name}"
}

module "aws_iam_access_key" {
  source = "./modules/aws_iam_access_key"

  aws_iam_user_name = "${module.aws_iam_user.aws_user_name}"

}

resource "aws_instance" "playground_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  count                  = var.server_count
  instance_type          = "t2.medium"
  subnet_id              = module.aws_basic_network.aws_subnet_id
  vpc_security_group_ids = ["${module.aws_basic_network.aws_default_sg_id}"]
  key_name               = var.pub_key_name

  root_block_device {
    volume_size = "10"  
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/${var.private_key_file}")
    host        = self.public_ip
  }

provisioner "file" {
    source      = "./scripts/web-ide"
    destination = "/tmp/"
  }

  # Run installation
  provisioner "remote-exec" {
    inline = [
      "chmod -R 755 /tmp/web-ide",
      "/tmp/web-ide/main.sh | tee -a /tmp/playground_install.log",
      "if [ -f \"/tmp/failed.txt\" ]; then exit 1; fi"
    ]
  }

provisioner "file" {
    source      = "./config/"
    destination = "/home/ec2-user/playground/"
}

provisioner "file" {
    source      = "./ansible/"
    destination = "/home/ec2-user/playground/"
}

provisioner "remote-exec" {
    inline = [
      "echo Security Group ID = ${module.aws_basic_network.aws_default_sg_id} > /home/ec2-user/playground/IDs.txt",
      "echo Subnet ID = ${module.aws_basic_network.aws_subnet_id} >> /home/ec2-user/playground/IDs.txt"
    ]
}

provisioner "remote-exec" {
    inline = [
      "aws configure set aws_access_key_id ${module.aws_iam_access_key.aws_user_key_id}",
      "aws configure set aws_secret_access_key ${module.aws_iam_access_key.aws_user_key_secret}"
    ]
}

provisioner "remote-exec" {
    inline = [
      "ssh-keygen -b 2048 -t rsa -f ~/.ssh/playground -q -N \"\""
    ]
}

  tags = {
    Name = "${var.pre_tag}_PLAYGROUND_${count.index + 1}"
    Owner = "${var.own_tag}"
    Environment = "${var.env_tag}"
  }
}

module "aws_iam_user" {
  source = "./modules/aws_iam_user"

    aws_iam_user_name = "playground_user"
    aws_iam_user_path = "/"
    environment_tag = "${var.env_tag}"
    owner_tag = "${var.own_tag}"
    prefix_tag = "${var.pre_tag}"

  }

module "aws_iam_user_policy" {

  source ="./modules/aws_iam_user_policy"
  aws_iam_policy_file = "${file("./modules/aws_iam_user_policy/policy/playground.json")}"
  aws_iam_policy_name = "PLAYGROUND-POLICY"
  aws_iam_user_name = "${module.aws_iam_user.aws_user_name}"

}

output "playground_url" {
  description = "URL(s) of the Playground instance"
  value = "${formatlist("http://%s:%s",aws_instance.playground_instance.*.public_ip,"8080")}"
}

output "securitygroup_id" {
  description = "Security Group ID"
  value       = "${module.aws_basic_network.aws_default_sg_id}"
}

output "subnet_id" {
  description = "Subnet ID"
  value       = "${module.aws_basic_network.aws_subnet_id}"
}

data "aws_ami" "amazon_linux" {
most_recent = true
owners = ["amazon"] # Canonical

  filter {
      name   = "name"
      values = ["amzn2-ami-hvm*x86_64-gp2"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
}