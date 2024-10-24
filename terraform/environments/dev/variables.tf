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

# need to get the public key from github secrets
variable "ssh_public_key" {
  type = string
  description = "The public key to setup ssh connection with the instances created"
}
