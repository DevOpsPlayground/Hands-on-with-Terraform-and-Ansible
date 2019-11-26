resource "aws_vpc" "aws_core_vpc" {
  cidr_block = var.aws_core_vpc_cidr

  tags = {
    Name = "${var.prefix_tag}_VPC"
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }
}

resource "aws_subnet" "aws_core_subnet1" {
  vpc_id                  = aws_vpc.aws_core_vpc.id
  cidr_block              = var.aws_core_subnet_cidr1
  availability_zone       = var.aws_core_az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix_tag}_SUBNET1"
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }
}

resource "aws_internet_gateway" "aws_core_igw" {
  vpc_id = aws_vpc.aws_core_vpc.id

  tags = {
    Name = "${var.prefix_tag}_IGW"
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }
}

resource "aws_default_route_table" "aws_core_rt" {
  default_route_table_id = aws_vpc.aws_core_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_core_igw.id
  }

  tags = {
    Name = "${var.prefix_tag}_RT"
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }
}

resource "aws_default_security_group" "aws_core_dsg" {
  vpc_id = aws_vpc.aws_core_vpc.id

  ingress {
    protocol    = "-1"
    self        = false
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${chomp(data.http.my_ip_address.body)}/32"]
  }

  ingress {
    protocol    = "-1"
    self        = false
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.aws_core_vpc_cidr}"]
  }

  ingress {
    protocol    = "-1"
    self        = false
    from_port   = 0
    to_port     = 0
    cidr_blocks = var.additional_public_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix_tag}_SG"
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }
}

data "http" "my_ip_address" {
  url = "http://ipv4.icanhazip.com"
}