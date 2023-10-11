#!/bin/bash

# Create a directory for your project (if it doesn't exist)
mkdir -p Terraform_task

# Change to the project directory and create opt directory
cd Terraform_task
mkdir /opt

# Initialize Terraform in your project directory
terraform init

# Create an execution plan
terraform plan -out=tfplan

# Apply the changes to create the SFTP server and security group
terraform apply tfplan

# Make the backup_script.sh file executable
chmod +x backup_script.sh

# Run the backup script in the background
./backup_script.sh &
