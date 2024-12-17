# VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-EKS-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {

    "kubernetes.io/cluster/eks-cluster" = "shared"
  }

  public_subnet_tags = {

    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }
}

#EKS

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  #version = "~> 20.31"

  cluster_name    = "eks-cluster"
  cluster_version = "1.25"

  # Optional
   cluster_endpoint_public_access = true

    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  # enable_cluster_creator_admin_permissions = true

  /* cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
  */

  eks_managed_node_groups = {
    nodes = {

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    tags = {
      Environment = "dev"
      Terraform   = "true"
    }
  }
}
