variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "ami_id" {
  description = "ID of the EC2 AMI to use"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for EC2 instance"
  type        = string
}

variable "security_group_name" {
  description = "Name of the existing AWS security group"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile for EC2 instance"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for backups"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM instance profile role."
  type        = string
}

#variable "local_network_cidr" {
#  description = "CIDR block for the local network"
#  type        = string
#}

variable "private_ip_cidr" {
  description = "CIDR block for the private IP address"
  type        = string
}
