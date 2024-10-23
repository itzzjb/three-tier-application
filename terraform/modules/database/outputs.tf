output "rds-instance-endpoint" {
  description = "The endpoint for the rds instance created"
  value = aws_db_instance.rds-instance.endpoint
}