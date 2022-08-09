#! /bin/bash

terraform apply --auto-approve

sleep 30

export ANSIBLE_HOST_KEY_CHECKING=False 

ansible-playbook -i ../reverse-proxy-nginx/inventory/prod.yml ../reverse-proxy-nginx/site.yml

ansible-playbook -i ../db-server-mysql/inventory/prod.yml ../db-server-mysql/site.yml

ansible-playbook -i ../apps-server/inventory/prod.yml ../apps-server/site.yml

ansible-playbook -i ../gitlab-ci/inventory/prod.yml ../gitlab-ci/site.yml

ansible-playbook -i ../monitoring/inventory/prod.yml ../monitoring/site.yml
