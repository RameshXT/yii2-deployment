#!/bin/bash

cd /home/ec2-user/yii2-deployment/nginx-reverse-proxy
sudo chmod 600 /root/.ssh/Primary.pem
ansible-playbook playbook.yml -i inventory.ini
