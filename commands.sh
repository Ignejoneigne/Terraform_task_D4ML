#!/bin/bash

# Update the system
sudo apt update

# Install unzip and git (if not already installed)
sudo apt install -y unzip git

# Download and install Terraform
wget https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_amd64.zip
unzip terraform_1.6.1_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -install-autocomplete

# Clone your Terraform project from GitHub
git clone https://github.com/Ignejoneigne/Terraform_task_D4ML.git

# Change to the project directory
cd Terraform_task_D4ML

# Initialize the Terraform configuration
terraform init

# Create an execution plan
terraform plan -out=tfplan

# Apply the changes to create the SFTP server and security group
terraform apply tfplan

# Make the backup_script.sh file executable
chmod +x backup_script.sh

# Run the backup script in the background
nohup ./backup_script.sh > backup_script.log 2>&1 &

# You can check the progress by tailing the log
tail -f backup_script.log
