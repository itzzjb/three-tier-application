output "rds_instance_endpoint" {
  description = "The endpoint for the RDS instance created"
  value       = aws_db_instance.db-instance.endpoint
}
