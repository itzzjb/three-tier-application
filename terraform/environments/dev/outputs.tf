output "public_instance_ip" {
  value = module.compute.public_instance_ip
}

output "private_instance_ip" {
  value = module.compute.private_instance_ip
}

output "rds_instance_endpoint" {
  value = module.database.rds_instance_endpoint
}
