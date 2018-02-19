variable "aws_profile" {
   description = "AWS Profile for credentials"
    default = "oreilly-aws"
}

variable "ssh_private_key_path" {
   description = "Path to EC2 SSH private key"
    default = "/Users/skane/.ssh/oreilly_aws"
}

variable "ssh_public_key_path" {
   description = "Path to EC2 SSH public key"
    default = "/Users/skane/.ssh/oreilly_aws.pub"
}

variable "public_ip_path" {
   description = "Path to file containing public IP"
    default = "/Users/skane/.public_home_ip"
}

