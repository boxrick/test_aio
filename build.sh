#!/bin/bash
# Quick and dirty AIO Openstack bash script

start=`date +%s`

git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
cd /opt/openstack-ansible
git checkout stable/queens
scripts/bootstrap-ansible.sh
scripts/bootstrap-aio.sh
cd /opt/openstack-ansible
export SCENARIO="aio_lxc"
openstack-ansible ./playbooks/setup-hosts.yml
openstack-ansible ./playbooks/setup-infrastructure.yml
openstack-ansible ./playbooks/setup-openstack.yml

end=`date +%s`
runtime=$((end-start))
echo "Total time: ${runtime}"
