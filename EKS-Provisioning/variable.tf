variable "vpc_cidr" {
  description = "value"
  type        = string
}

variable "subnet_Pivate_cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}

variable "subnet_Public_cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}
