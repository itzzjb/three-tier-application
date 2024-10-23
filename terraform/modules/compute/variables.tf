variable "public_subnet_id" {
  description = "The subnet ID for the public instance"
  type        = string
}

variable "private_subnet_id" {
  description = "The subnet ID for the private instance"
  type        = string
}

variable "public_security_group_id" {
  description = "The security group ID for the public instance"
  type        = string
}

variable "private_security_group_id" {
  description = "The security group ID for the private instance"
  type        = string
}
