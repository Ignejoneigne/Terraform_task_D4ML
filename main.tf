data "aws_vpc" "main" {
  default = true
}

resource "aws_security_group" "sftp_security_group" {
  name        = var.security_group
  description = "Security group for SFTP server"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 15955
    to_port     = 15955
    protocol    = "tcp"
    cidr_blocks = [var.private_ip_cidr]
  }
}

resource "aws_instance" "sftp_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.sftp_security_group.name]
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
    Name        = "SFTP Server"
    Environment = "D4ML"
    Owner       = "Igne"
  }
}
