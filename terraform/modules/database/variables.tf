variable "database_name" {
  type        = string
  description = "The database name"
}

variable "database_username" {
  type        = string
  description = "The database admin account username"
}

variable "database_password" {
  type        = string
  description = "The database admin account password"
}

variable "private_subnet_id" {
  type        = string
  description = "The private subnet id got from the network module"
}

variable "private_subnet_2_id" {
  type        = string
  description = "The private subnet 2 id got from the network module"
}

variable "private_security_group_id" {
  type        = string
  description = "The ID of the private security group from the compute module"
}