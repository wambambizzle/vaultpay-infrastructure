output "bucket_id" {
  description = "The name of the S3 bucket"
  value       = module.bucket.bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.bucket.bucket_arn
}

output "bucket_domain_name" {
  description = "The bucket URL"
  value       = module.bucket.bucket_domain_name
}