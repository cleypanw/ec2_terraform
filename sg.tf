#########
# Security group configuration

resource "aws_security_group" "sg-ec2" {

  description = "SG for ec2-instance"
  name        = local.sg_name
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "sg.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "sg-ec2"
    yor_trace            = "16448a46-598b-4f09-8c35-adf3c14404fa"
    nils                 = "custom"
  }
}