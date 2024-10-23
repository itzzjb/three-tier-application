output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "public-subnet-id" {
  value = aws_subnet.public-subnet.id
}

output "private-subnet-id" {
  value = aws_subnet.private-subnet.id
}

output "private-subnet-2-id" {
  value = aws_subnet.private-subnet-2.id
}

output "public-security-group-id" {
  value = aws_security_group.public-security-group.id
}

output "private-security-group-id" {
  value = aws_security_group.private-security-group.id
}
