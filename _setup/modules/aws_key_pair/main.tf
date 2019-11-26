resource "aws_key_pair" "aws_core_keypair" {
    key_name   = var.aws_core_public_key_name
    public_key = file("~/.ssh/${var.aws_core_public_key_file}")
}