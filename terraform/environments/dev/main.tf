module "network" {
  source = "../../modules/network"
  # No variables needed for now
}

module "compute" {
  source              = "../../modules/compute"
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  private_subnet_ids  = module.network.private_subnet_ids
}

module "database" {
  source              = "../../modules/database"
  database_name       = var.database_name
  database_username   = var.database_username
  database_password   = var.database_password
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
}
