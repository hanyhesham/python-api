terraform {
  backend "s3" {
    bucket = "python-api-terraform"
    key    = "dev/terraform.tfstate"
    region = "us-east-2"
  }
}

module "iam" {
  source = "./iam"
}

module "ecr" {
  source = "./ecr"
}

module "vpc" {
  source = "./vpc"
}

module "eks" {
  source              = "./eks"
  vpc_id              = module.vpc.id
  vpc_private_subnets = module.vpc.private_subnets
}