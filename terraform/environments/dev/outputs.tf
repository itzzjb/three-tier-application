output "public_instance_ip" {
  value = module.compute.public-instance-ip
}

output "private_instance_ip" {
  value = module.compute.private-instance-ip
}

output "rds_instance_endpoint" {
  value = module.database.rds-instance-endpoint
}
