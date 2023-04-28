#!/bin/bash

# Append the package and library requirements to the README.md file
cat <<EOT >> README.md
## Prerequisites
- Ansible 2.9 or higher
- Terraform 0.14 or higher

## Ansible Roles
1. wireguard: Sets up WireGuard VPN server
2. user_auth: Configures user authentication API

## Usage
1. Set up your Terraform infrastructure by navigating to the appropriate environment directory (e.g., terraform/environments/development) and running \`terraform init\` and \`terraform apply\`.
2. Run the Ansible playbooks to set up the VPN server and user authentication API: \`ansible-playbook ansible/playbooks/wireguard_setup.yml\` and \`ansible-playbook ansible/playbooks/user_auth_setup.yml\`.
EOT

echo "README.md updated successfully."

