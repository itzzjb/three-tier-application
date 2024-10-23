output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "public_security_group_id" {
  value = aws_security_group.public-security-group.id
}

output "private_security_group_id" {
  value = aws_security_group.private-security-group.id
}
