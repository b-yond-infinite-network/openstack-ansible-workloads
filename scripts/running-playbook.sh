#!/bin/bash

echo "---got signal handler at : $WC_NOTIFY" > /tmp/heat-signaling
echo "[LOCAL ANSIBLE]- Executing playbook -- /etc/ansible/openstack-ansible.yaml with role=" + $ROLE >> /tmp/install_output

ansible-playbook -s /etc/ansible/openstack-ansible.yaml -e action=local -e role=$ROLE

echo "[LOCAL ANSIBLE]- --> Playbook executed" >> /tmp/install_output
$WC_NOTIFY --data-binary '{"status": "SUCCESS"}'
