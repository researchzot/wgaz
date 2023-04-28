#!/bin/bash

# Define Azure API key variable
AZURE_API_KEY="your_api_key_here"

# Define the directory paths for Ansible roles
BASE_DIR="./ansible/roles"
WG_DIR="$BASE_DIR/wireguard/tasks"
UA_DIR="$BASE_DIR/user_auth/tasks"
FW_DIR="$BASE_DIR/firewall/tasks"
DNS_TLS_DIR="$BASE_DIR/dns_tls/tasks"

# Create necessary directories if they do not exist
mkdir -p "$WG_DIR" "$UA_DIR" "$FW_DIR" "$DNS_TLS_DIR"

# Write tasks to main.yml for WireGuard role
echo "- name: Install WireGuard
  apt:
    name: wireguard
    state: present
  become: yes

- name: Configure WireGuard
  template:
    src: wg0.conf.j2
    dest: /etc/wireguard/wg0.conf
    owner: root
    group: root
    mode: '0600'
  become: yes" > "$WG_DIR/main.yml"

# Write tasks to main.yml for User Auth role
echo "- name: Install Python and Flask
  apt:
    name:
      - python3
      - python3-pip
    state: present
  become: yes

- name: Install Flask and other required packages
  pip:
    name:
      - flask
      - flask-sqlalchemy
      - flask-login
    state: present
    executable: pip3" > "$UA_DIR/main.yml"

# Write tasks to main.yml for Firewall role
echo "- name: Install UFW
  apt:
    name: ufw
    state: present
  become: yes

- name: Configure UFW
  ufw:
    rule: allow
    port: '{{ item }}'
    proto: tcp
  with_items:
    - 22
    - 80
    - 443
  become: yes

- name: Enable UFW
  ufw:
    state: enabled
  become: yes" > "$FW_DIR/main.yml"

# Write tasks to main.yml for DNS over TLS role
echo "- name: Install Stubby
  apt:
    name: stubby
    state: present
  become: yes

- name: Configure Stubby
  template:
    src: stubby.yml.j2
    dest: /etc/stubby/stubby.yml
  become: yes

- name: Restart Stubby service
  systemd:
    name: stubby
    state: restarted
  become: yes" > "$DNS_TLS_DIR/main.yml"

