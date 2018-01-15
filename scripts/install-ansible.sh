#!/bin/bash

echo "---got signal handler at : $WC_NOTIFY" > /tmp/heat-signaling
echo "Ansible is being installed" > /tmp/install_output

apt update
apt -y install ansible
echo -e "[localhost]\n127.0.0.1 ansible_connection=local" >> /etc/ansible/hosts

echo "Ansible installed" >> /tmp/install_output
$WC_NOTIFY --data-binary '{"status": "SUCCESS"}'
