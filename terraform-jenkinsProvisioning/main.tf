# VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.subnet_cidr

  enable_dns_hostnames = true

  tags = {
    jenkins = "J-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

}

# SG

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkis-SG"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
     {
      from_port   = 22
      to_port     = 22
      protocol    = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    name = "jenkins-securityG"
  }
}



# EC2


