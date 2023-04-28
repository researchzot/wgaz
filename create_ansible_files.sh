#!/bin/bash

# Create necessary directories
mkdir -p ansible/playbooks ansible/roles/wireguard/tasks ansible/roles/user_auth/tasks ansible/roles/user_auth/templates

# Create wireguard_setup.yml playbook
cat <<EOT > ansible/playbooks/wireguard_setup.yml
---
- name: Set up WireGuard VPN server
  hosts: vpn
  roles:
    - wireguard
EOT

# Create user_auth_setup.yml playbook
cat <<EOT > ansible/playbooks/user_auth_setup.yml
---
- name: Set up user authentication API
  hosts: api
  roles:
    - user_auth
EOT

# Create wireguard main.yml
cat <<EOT > ansible/roles/wireguard/tasks/main.yml
---
- name: Install WireGuard
  # Add your WireGuard installation task here

- name: Generate server and client keys
  # Add your task to generate server and client keys here

- name: Configure WireGuard interface
  # Add your task to configure WireGuard interface here

- name: Enable and start WireGuard service
  # Add your task to enable and start WireGuard service here
EOT

# Create user_auth main.yml
cat <<EOT > ansible/roles/user_auth/tasks/main.yml
---
- name: Install Python and Flask
  # Add your Python and Flask installation task here

- name: Configure the user authentication API service
  template:
    src: auth_api.service.j2
    dest: /etc/systemd/system/auth_api.service
  become: yes

- name: Install Python dependencies
  # Add your task to install Python dependencies here

- name: Start the user authentication API service
  systemd:
    name: auth_api
    state: started
    enabled: yes
  become: yes
EOT

# Create auth_api.service.j2 template
cat <<EOT > ansible/roles/user_auth/templates/auth_api.service.j2
[Unit]
Description=User Authentication API
After=network.target

[Service]
User=api
WorkingDirectory=/path/to/auth_api
ExecStart=/usr/bin/python3 /path/to/auth_api/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOT

echo "Ansible playbooks and roles created successfully."

