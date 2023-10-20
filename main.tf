# Define the VPC
data "aws_vpc" "default" {
  default = true
}

# Create a security group for the SFTP server
resource "aws_security_group" "sftp_security_group" {
  name        = var.security_group_name
  description = "Security group for the SFTP server"
  vpc_id      = data.aws_vpc.default.id

  # Allow inbound traffic on port 15955 from the entire VPC CIDR block
  ingress {
    from_port   = 15955
    to_port     = 15955
    protocol    = "tcp"
    cidr_blocks = ["${aws_vpc.default.cidr_block}"]
  }

  # Allow inbound traffic on port 80 and 443 from the user's IP address
  ingress {
    from_port   = 80
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_security_group.sftp_security_group.self_cidr}"]
  }

  # Allow outbound traffic to all destinations
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "sftp_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.sftp_security_group.id]
  iam_instance_profile = "role-d4ml-cloud9-deployment"
  user_data     = <<-EOF
    #!/bin/bash

    export S3_BUCKET_NAME="${var.s3_bucket_name}"

    while true; do
      if aws s3 sync "/opt" "s3://$S3_BUCKET_NAME/" --delete; then
        echo "Backup completed successfully at \$(date)"
      else
        echo "Backup failed at \$(date)"
      fi
      sleep 60
    done
    EOF

  tags = {
    Name = "SFTP Server"
    Environment = "D4ML"
    Owner = "Igne"
  }
}