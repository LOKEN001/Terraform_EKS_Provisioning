# VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-EKS-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.subnet_Public_cidr
  private_subnets = var.subnet_Pivate_cidr

  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
  
    "kubernetes.io/cluster/eks-cluster" =    "shared"
    }

    public_subnet_tags = {
         
      "kubernetes.io/cluster/eks-cluster" = "shared"
      "kubernetes.io/role/internal-elb"   = "1"
    }

    private_subnet_tags = {
        "kubernetes.io/cluster/eks-cluster" =   "shared"
        "kubernetes.io/role/internal-elb"   = "1"
    }
  }
