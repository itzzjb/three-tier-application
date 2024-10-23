variable "vpc_id" {
  type = string
  description = "The VPC id got from the network module"
}

variable "public_subnet_id" {
    type = string
    description = "The public subnet id got from the network module"
}

variable "private_subnet_id" {
    type = string
    description = "The private subnet id got from the network module"
}