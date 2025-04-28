#!/bin/bash

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Install Ansible & dependencies
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y --update ppa:ansible/ansible
sudo apt install -y ansible
ansible --version
sudo apt install -y ansible-lint

# Add localhost to default inventory
LOCAL_CONN='localhost ansible_connection=local'
ANSIBLE_HOST=/etc/ansible/hosts

if ! grep -q $LOCAL_CONN $ANSIBLE_HOST; then
    echo $LOCAL_CONN | sudo tee -a $ANSIBLE_HOST
else
    echo "$LOCAL_CONN already added to $ANSIBLE_HOST."   
fi

# Install SSH for ansible
sudo apt install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh