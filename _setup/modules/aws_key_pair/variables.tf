variable "aws_core_public_key_file" {
    type = string
    description = "Name of public key file located under ~/.ssh"
}


variable "aws_core_public_key_name" {
    type = string
    description = "Name of Key pair in AWS. Ensure this name matches the key pair manually uploaded if using csp."
}