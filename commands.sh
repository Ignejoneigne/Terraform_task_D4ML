#!/bin/bash

# Update the system
sudo apt update

# Install unzip and git (if not already installed)
sudo apt install -y unzip git

# Download and install Terraform (latest version)
wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
unzip terraform_1.0.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Install the AWS CLI
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

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
