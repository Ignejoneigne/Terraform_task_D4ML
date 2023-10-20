data "aws_vpc" "default" {
  default = true
}
# Create new security group
#resource "aws_security_group" "sftp_security_group" {
#  name        = "new_security_group"
#  description = "Security group"
#  vpc_id      = data.aws_vpc.default.id
#
#  ingress {
#    from_port   = 15955
#    to_port     = 15955
#    protocol    = "tcp"
#  }
#}

resource "aws_instance" "sftp_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]
  #security_groups = [var.security_group]
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



