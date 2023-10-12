#!/bin/bash

sudo apt update

# Install Terraform
wget https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_amd64.zip
unzip terraform_1.6.1_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version

# Create a directory for your project (if it doesn't exist)
mkdir -p Terraform_task

# Change to the project directory and create an opt directory
cd Terraform_task
mkdir -p opt

# Initialize Terraform in your project directory
terraform init

# Create an execution plan
terraform plan -out=tfplan

# Apply the changes to create the SFTP server and security group
terraform apply tfplan

# Make the backup_script.sh file executable
chmod +x backup_script.sh

# Run the backup script in the background
nohup ./backup_script.sh &
