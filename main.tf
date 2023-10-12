provider "aws" {
  region  = var.aws_region
  profile = "d4ml-intern"
}

data "aws_vpc" "main" {
  default = true
}

resource "aws_security_group" "sftp_security_group" {
  name        = var.security_group
  description = "Security group"
  vpc_id      = "vpc-0faf1b0abcce85736"

  ingress {
    from_port   = 15955
    to_port     = 15955
    protocol    = "tcp"
  }
}

resource "aws_instance" "sftp_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  security_groups = [var.security_group]
  iam_instance_profile = "role-d4ml-cloud9-deployment"
  user_data     = <<-EOF
    #!/bin/bash

    while true; do
      if aws s3 sync "/opt" "s3://${var.s3_bucket_name}/Ignes" --delete; then
        echo "Backup completed successfully at \$(date)"
      else
        echo "Backup failed at \$(date)"
      fi
      sleep 60
    done
    EOF

  tags = {
    Name = "SFTP Server"
  }
}

resource "aws_s3_bucket_policy" "backup_policy" {
  bucket = aws_s3_bucket.backup.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
        ],
        Effect = "Allow",
        Resource = [
          aws_s3_bucket.backup.arn,
          "${aws_s3_bucket.backup.arn}/*",
        ],
        Principal = "*",
      },
    ],
  })
}
