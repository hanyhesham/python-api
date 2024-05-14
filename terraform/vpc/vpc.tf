data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/dev" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/dev" = "shared"
    "kubernetes.io/role/elb"    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/dev"       = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}