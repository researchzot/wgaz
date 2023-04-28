#!/bin/bash

# Set API key placeholder
api_key_placeholder="YOUR_API_KEY_HERE"

# Create directory structure
mkdir -p ansible/roles/wireguard ansible/roles/user_auth ansible/playbooks terraform/modules/vpn_server terraform/modules/user_auth_api terraform/environments/development terraform/environments/production user-auth-api/controllers user-auth-api/models user-auth-api/routes scripts/user_management scripts/monitoring tests

# Create necessary files
touch ansible/playbooks/wireguard_setup.yml ansible/playbooks/user_auth_setup.yml terraform/main.tf user-auth-api/.env.example .gitignore README.md

# Populate the user-auth-api/.env.example file with the API key placeholder
echo "API_KEY=$api_key_placeholder" > user-auth-api/.env.example

# Populate the .gitignore file with common patterns to ignore
cat <<EOT >> .gitignore
# Ignore Terraform state files
*.tfstate
*.tfstate.backup

# Ignore Terraform plan files
*.tfplan

# Ignore Terraform provider plugins
.terraform/

# Ignore environment variables files
.env
EOT

# Populate the README.md file with basic project information
cat <<EOT >> README.md
# Project Name

## Overview
This project creates a scalable VPN infrastructure using Terraform and Ansible.

## Setup
1. Replace the API key placeholder in the user-auth-api/.env.example file with your actual API key.
2. Rename user-auth-api/.env.example to user-auth-api/.env
3. Follow the remaining setup instructions in this document.
EOT

echo "File structure and initial files created successfully."

