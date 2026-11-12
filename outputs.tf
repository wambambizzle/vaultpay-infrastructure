output "ecr_repository_url" {
  description = "URL of the ECR repository holding the VaultPay container image. Use this when pushing images mnanually with .."
  value       = aws_ecr_repository.vaultpay.repository_url
}

output "runtime_bucket_name" {
  description = "Name of the S3 bucket holding VaultPay runtime data."
  value       = aws_s3_bucket.runtime.id
}

output "alb_dns_name" {
  description = "Public DNS name of the application load balancer."
  value       = aws_lb.app.dns_name 
}
