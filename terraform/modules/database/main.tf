resource "aws_db_instance" "db-instance" {
  identifier             = "example-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" # Free tier eligible
  db_name                = var.database_name
  username               = var.database_username
  password               = var.database_password
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "example-db"
  }
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "example-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "example-subnet-group"
  }
}
