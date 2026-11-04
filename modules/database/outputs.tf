output "db_endpoint" {
  description = "The end point for the RDS database"
  value       = aws_db_instance.vaultpay.endpoint
}

output "db_port" {
  description = "The port for the RDS database"
  value       = aws_db_instance.vaultpay.port
}

output "db_name" {
  description = "The name for the RDS database"
  value       = aws_db_instance.vaultpay.db_name
}

output "db_security_group_id" {
  description = "The security group id for the RDS database"
  value       = aws_db_instance.vaultpay.vpc_security_group_ids[0]
}

output "db_master_secret_arn" {
  description = "The master secret arn for the RDS database"
  value       = aws_db_instance.vaultpay.master_user_secret[0].secret_arn
}
