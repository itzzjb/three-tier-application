output "public_instance_ip" {
  value = aws_instance.public-instance.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private-instance.private_ip
}
