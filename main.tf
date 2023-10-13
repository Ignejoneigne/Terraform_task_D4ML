data "aws_vpc" "main" {
  default = true
}

data "aws_security_group" "existing_sftp_security_group" {
  name   = "igne_group_2023"
  vpc_id = "vpc-0faf1b0abcce85736"
}

resource "aws_instance" "sftp_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  security_groups = [data.aws_security_group.existing_sftp_security_group.id]
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
