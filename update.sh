#!/bin/bash

# Create directories and files for Terraform and Ansible
mkdir -p terraform
mkdir -p ansible/roles/wireguard/tasks
mkdir -p ansible/roles/wireguard/handlers
mkdir -p ansible/roles/wireguard/templates

touch terraform/main.tf
touch terraform/variables.tf
touch terraform/outputs.tf
touch terraform/terraform.tfvars
touch ansible/wireguard.yml
touch ansible/roles/wireguard/tasks/main.yml
touch ansible/roles/wireguard/handlers/main.yml
touch ansible/roles/wireguard/templates/wg0.conf.j2
touch README.md

# Populate Terraform and Ansible files with content
# Content for Terraform and Ansible files has been omitted for brevity.
# Please refer to the previous responses for the content of these files.

# Update README.md with the project setup instructions
cat > README.md <<EOL
# WireGuard VPN on Azure

This project sets up a WireGuard VPN server on Azure using Terraform and Ansible.

## Prerequisites

- Azure account
- Azure CLI installed and authenticated
- Terraform (version x.y.z)
- Ansible (version x.y.z)

## Steps

1. Clone the repository and navigate to the project directory.

2. Update the \`terraform.tfvars\` file with your Azure subscription ID and other required variables.

3. Initialize and apply the Terraform configuration:
   \```
   terraform init
   terraform apply
   \```

4. Use the Terraform output to create an Ansible inventory file.

5. Configure the WireGuard VPN server using Ansible:
   \```
   ansible-playbook -i inventory.ini ansible/wireguard.yml
   \```

6. Connect to the WireGuard VPN server using your preferred client, providing the necessary client configuration generated by the server.

## Cost Optimization and Metrics

The infrastructure is designed to be cost-efficient and to scale based on demand. The project collects metrics such as the number of users, failed/successful connections, and bandwidth usage without compromising user privacy.
EOL

