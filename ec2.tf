resource "aws_key_pair" "ssh_key" {
  key_name   = local.sshkey_name
  public_key = "${var.public_ssh_key}"
  tags = {
    git_commit           = "9f31b4a21533db6de656b2e4d05b77aa4b67d8a2"
    git_file             = "ec2.tf"
    git_last_modified_at = "2023-12-07 10:39:48"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "ssh_key"
    yor_trace            = "695676df-a93f-4e86-8892-68da78fb5647"
    nils                 = "custom"
  }
}

resource "aws_instance" "ec2instance" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  private_ip             = "10.0.4.10"
  vpc_security_group_ids = ["${aws_security_group.sg-ec2.id}"]

  #checkov:skip=CKV_AWS_88
  associate_public_ip_address = true

  key_name = "${aws_key_pair.ssh_key.key_name}"

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
    encrypted             = true
  }

  ## https://docs.bridgecrew.io/docs/bc_aws_general_31
  #metadata_options {
  #  http_endpoint = "enabled"
  #  http_tokens   = "required"
  #}

  depends_on = [
    aws_key_pair.ssh_key
  ]

  tags = {
    Name                 = local.ec2_instance_name
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "ec2.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "ec2instance"
    yor_trace            = "1182a718-57ef-4eb5-aeb5-ffadf00473ca"
    nils                 = "custom"
  }
}