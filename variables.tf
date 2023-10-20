variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "private_ip_cidr" {
  description = "CIDR block for the private IP address"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for backups"
  type        = string
}

variable "ami_id" {
  description = "ID of the EC2 AMI to use"
  type        = string
}

variable "iam_instance_profile" {
  description = "Name of the IAM instance profile for the EC2 instance"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for EC2 instance"
  type        = string
}

variable "security_group" {
  description = "Name of the security group to attach to the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to use."
  type        = string
}
