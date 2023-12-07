provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

data "aws_availability_zones" "available" {}

# Ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Generate Random 3 chars
resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}

# Define local var that will be use by TF
locals {
  vpc_name          = "${var.name_prefix}-vpc-${random_string.suffix.result}"
  ec2_instance_name = "${var.name_prefix}-ec2-instance-${random_string.suffix.result}"
  sshkey_name       = "${var.name_prefix}-sshkey-${random_string.suffix.result}"
  sg_name           = "${var.name_prefix}-sg-${random_string.suffix.result}"
}




