resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name                 = local.vpc_name
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "vpc.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "my_vpc"
    yor_trace            = "429710f9-fc63-4b2e-8fa5-7cb6303dc846"
    nils                 = "custom"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name                 = local.public_subnet_name
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "vpc.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "public"
    yor_trace            = "4c37b265-5a06-4859-b296-6572b426d666"
    nils                 = "custom"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                 = local.private_subnet_name
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "vpc.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "private"
    yor_trace            = "f813af94-4bff-4163-98a1-582497e196d4"
    nils                 = "custom"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name                 = local.igw_name
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "vpc.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "gw"
    yor_trace            = "a18d2b51-0d17-4547-a62f-ddfe26820ab4"
    nils                 = "custom"
  }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name                 = local.rt_name
    git_commit           = "2d96cb9c0c6ebbc0d4527f84a762096bffdb8411"
    git_file             = "vpc.tf"
    git_last_modified_at = "2023-12-07 12:39:28"
    git_last_modified_by = "cley@paloaltonetworks.com"
    git_modifiers        = "cley"
    git_org              = "cleypanw"
    git_repo             = "ec2_terraform"
    yor_name             = "second_rt"
    yor_trace            = "a5356cce-d544-4716-890a-8cce99674639"
    nils                 = "custom"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.second_rt.id
}