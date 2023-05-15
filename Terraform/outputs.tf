output "s3_bucket_name" {
  value = module.s3_bucket.bucket_name
}

output "frontend_instance_public_ip" {
  value = aws_instance.frontend_instance.public_ip
}

output "backend_instance_public_ip" {
  value = aws_instance.backend_instance.public_ip
}