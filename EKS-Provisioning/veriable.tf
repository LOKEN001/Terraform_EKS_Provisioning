variable "vpc_cidr" {
  description = "value"
  type        = string
}

variable "private_subnets" {
  description = "Subnet CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnet CIDR"
  type        = list(string)
}
