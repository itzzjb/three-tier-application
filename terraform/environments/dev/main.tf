module "network" {
  source = "../../modules/network"
}

module "compute" {
  source = "../../modules/compute"
  vpc_id = module.network.vpc-id
  private_subnet_id = module.network.private-subnet-id
  public_subnet_id = module.network.public-subnet-id
}

module "database" {
  source            = "../../modules/database"
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  private_subnet_id = module.network.private-subnet-id
  private_subnet_2_id = module.network.private-subnet-2-id 
  private_security_group_id = module.compute.private-security-group-id
}
