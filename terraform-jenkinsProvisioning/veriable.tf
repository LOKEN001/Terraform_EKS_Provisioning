variable "vpc_cidr" {
  description = "value"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance"
  type        = string
}