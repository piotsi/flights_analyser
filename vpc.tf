data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "random_shuffle" "az" {
  input        = [join("", [var.aws_region, "a"]), join("", [var.aws_region, "b"]), join("", [var.aws_region, "c"]), join("", [var.aws_region, "d"])]
  result_count = 3
}

resource "aws_vpc" "vpc_main" {
  cidr_block                       = var.vpc_main_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
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
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.sn_private_one_cidr
  availability_zone = element("${random_shuffle.az.result}", 0)

  tags = {
    Name = "sn_private_one"
  }
}

resource "aws_subnet" "sn_private_two" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.sn_private_two_cidr
  availability_zone = element("${random_shuffle.az.result}", 1)

  tags = {
    Name = "sn_private_two"
  }
}

resource "aws_subnet" "sn_private_three" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.sn_private_three_cidr
  availability_zone = element("${random_shuffle.az.result}", 2)

  tags = {
    Name = "sn_private_three"
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

resource "aws_route_table_association" "rt_sn_private_one_association" {
  subnet_id      = aws_subnet.sn_private_one.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_sn_private_two_association" {
  subnet_id      = aws_subnet.sn_private_two.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_sn_private_three_association" {
  subnet_id      = aws_subnet.sn_private_three.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_sn_public_one_association" {
  subnet_id      = aws_subnet.sn_public_one.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc_main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.rt_private.id, aws_route_table.rt_public.id]


  depends_on = [
    aws_msk_cluster.msk_cluster
  ]

  tags = {
    Environment = "vpc_endpoint_s3"
  }
}