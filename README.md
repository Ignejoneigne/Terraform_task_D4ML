# Terraform_task_D4ML

As a junior DevOps engineer, you need to create Infrastructure as a Code for our SFTP server.

Description:

You need to use default VPC in Frankfurt region.

SFTP server should listen on 15955 port
This port must be available only from the local network and private IP address of the executer
SFTP server must be available only for user "admin"
S3 bucket should be used to backup /opt/* from SFTP server
A backup must be done every 1 minute and overwrite files with the same names


