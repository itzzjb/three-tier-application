variable "vpc_id" {
  type        = string
  description = "The VPC id got from the network module"
}

variable "public_subnet_id" {
  type        = string
  description = "The public subnet id got from the network module"
}

variable "private_subnet_id" {
  type        = string
  description = "The private subnet id got from the network module"
}

# need to get the public key from github secrets
variable "ssh_public_key" {
  type = string
  description = "The public key to setup ssh connection with the instances created"
}