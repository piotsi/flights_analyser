data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_vpc" "vpc_main" {
  cidr_block                       = var.vpc_main_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = false
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "vpc_main"
  }
}

resource "aws_subnet" "sn_public_one" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = var.sn_public_one_cidr

  tags = {
    Name = "sn_public_one"
  }
}

resource "aws_subnet" "sn_private_one" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = var.sn_private_one_cidr

  tags = {
    Name = "sn_private_one"
  }
}



resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    gateway_id = aws_internet_gateway.igw_main.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "route_table_public"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "route_table_private"
  }
}

resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "igw_main"
  }
}

resource "aws_route_table_association" "rt_sn_public_one_association" {
  subnet_id      = aws_subnet.sn_public_one.id
  route_table_id = aws_route_table.rt_public.id
}
