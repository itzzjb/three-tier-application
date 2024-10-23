variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "database_username" {
  description = "The database admin account username"
  type        = string
}

variable "database_password" {
  description = "The database admin account password"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}
