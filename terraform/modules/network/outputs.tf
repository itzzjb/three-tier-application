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
