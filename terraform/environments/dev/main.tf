module "network" {
  source = "../../modules/network"
}

module "compute" {
  source = "../../modules/compute"
}

module "database" {
  source            = "../../modules/database"
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
}
