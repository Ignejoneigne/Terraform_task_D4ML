provider "aws" {
  region  = var.aws_region
  profile = "d4ml-intern"
}

resource "aws_security_group" "sftp_security_group" {
  name        = "sftp-security-group"
  description = "Security group for SFTP server"
  vpc_id        = data.aws_vpc.main.id

  ingress {
    from_port   = 15955
    to_port     = 15955
    protocol    = "tcp"
    #cidr_blocks = ["192.168.1.0/24", "5.20.132.172/32"]
  }
}

resource "aws_instance" "sftp_server" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
#  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.sftp_security_group.name]
#  availability_zone = var.aws_region
  iam_instance_profile = "role-d4ml-cloud9-deployment"
#  user_data     = file("backup_script.sh")
  user_data     = file("${path.module}/backup_script.sh")
  tags = {
    Name = var.instance_name
  }
}

#resource "aws_subnet" "private_subnet" {
#  vpc_id     = data.aws_vpc.main.id
#  cidr_block = var.local_network_cidr
#}

data "aws_vpc" "main" {
  default = true
}

resource "aws_s3_object" "sftp_backup" {
  bucket = "d4ml-bucket"
  key    = "Ignes/"
  source = "C:\\Users\\igne.jone\\project0\\Terraform_task\\opt"
}
