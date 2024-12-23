# VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.subnet_cidr

  enable_dns_hostnames = true

  tags = {
    jenkins     = "J-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

}

# SG

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "Jenkis-SG"
  vpc_id = module.vpc.vpc_id #fatching vpc id from vpc module

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks =  "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks =  "0.0.0.0/0"
    }
  ]

  tags = {
    name = "jenkins-securityG"
  }
}



# EC2


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-master"

  instance_type               = var.instance_type
  key_name                    = "terra-key"
  monitoring                  = true
  vpc_security_group_ids      = [module.vote_service_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  user_data = file("toolsinstallation.sh")

  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}