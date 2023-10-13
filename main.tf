data "aws_vpc" "main" {
  default = true
}

resource "aws_security_group" "sftp_security_group" {
  name        = var.security_group
  description = "Security group"
  vpc_id      = vpc-0faf1b0abcce85736

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
  iam_instance_profile = var.iam_instance_profile
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
    Name        = "SFTP Server"
    Environment = "D4ML"
    Owner       = "Igne"
  }
}
