module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc_main"
  cidr = var.vpc_main_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  #   msk_subnets     = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  vpc_tags = {
    Name = "vpc_main"
  }
}
