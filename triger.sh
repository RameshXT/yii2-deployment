#!/bin/bash

cd /home/ec2-user/yii2-deployment/nginx-reverse-proxy
sudo chmod 600 /root/.ssh/Primary.pem

# Load the private key into the SSH agent
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/Primary.pem

# Run the Ansible playbook
ansible-playbook playbook.yml -i inventory.ini
