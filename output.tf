output "public_ip" {
  value = aws_instance.sftp_server.public_ip
}

output "s3_bucket_name" {
  value = var.s3_bucket_name
}