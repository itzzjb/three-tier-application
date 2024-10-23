module "network" {
  source = "../../modules/network"
}

module "compute" {
  source = "../../modules/compute"
  vpc_id = module.network.vpc-id
  # need to pass in the outputs from the network module as inputs to the compute module
  private_subnet_id = module.network.private-subnet-id
  public_subnet_id  = module.network.public-subnet-id
}

module "database" {
  source = "../../modules/database"
  # need to pass in the database credentials into the database module that we are specifying in the terraform.tfvars file in the dev environment
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  # need to pass in the outputs from the network and compute modules as inputs to the database module
  private_subnet_id         = module.network.private-subnet-id
  private_subnet_2_id       = module.network.private-subnet-2-id
  private_security_group_id = module.compute.private-security-group-id
}
