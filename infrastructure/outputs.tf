output "public-instance-ip" {
  description = "The public ip of the instance in public subnet"
  value = aws_instance.public-instance.public_ip
}

output "private-instance-ip" {
  description = "The private ip of the instance in the private subnet"
  value = aws_instance.private-instance.private_ip
}

output "rds-instance-endpoint" {
  description = "The endpoint for the rds instance created"
  value = aws_db_instance.rds-instance.endpoint
}