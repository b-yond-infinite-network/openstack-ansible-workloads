#!/bin/bash

echo "---got signal handler at : $WC_NOTIFY" > /tmp/heat-signaling
echo "Openstack Ansible roles are being installed" >> /tmp/install_output

cd /tmp/
git clone https://github.com/internap/openstack-ansible-heat.git
cp -R /tmp/openstack-ansible+heat /etc/ansible/

echo "Openstack Ansible roles installed" >> /tmp/install_output
$WC_NOTIFY --data-binary '{"status": "SUCCESS"}'
