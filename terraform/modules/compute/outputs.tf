output "public-instance-ip" {
  description = "The public ip of the instance in public subnet"
  value       = aws_instance.public-instance.public_ip
}

output "private-instance-ip" {
  description = "The private ip of the instance in the private subnet"
  value       = aws_instance.private-instance.private_ip
}

output "private-security-group-id" {
  description = "The ID of the private security group"
  value       = aws_security_group.private-security-group.id
}
