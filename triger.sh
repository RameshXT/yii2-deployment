#!/bin/bash

cd /home/ec2-user/yii2-deployment/nginx-reverse-proxy

ansible-playbook playbook.yml -i inventory.ini
