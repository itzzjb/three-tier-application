# creating rds instance (mysql)
resource "aws_db_instance" "rds-instance" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = var.database_name
  username               = var.database_username
  password               = var.database_password
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.id
  vpc_security_group_ids = [aws_security_group.private-security-group.id] # setting up security groups for the rds instance
  skip_final_snapshot    = true                                           # skipping taking a final snapshot before deletion
  publicly_accessible    = false                                          # the rds instance is not allowed to access from outside the vpc
}

# creating the db subnet group to the rds instance
# this lists the subnets that the db instance will be deployed
resource "aws_db_subnet_group" "db-subnet-group" {
  subnet_ids = [aws_subnet.private-subnet.id, aws_subnet.private-subnet-2.id]
  tags = {
    Name = "app-db-subnet-group"
  }
}