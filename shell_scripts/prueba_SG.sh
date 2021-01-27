#!/bin/sh

source /root/bin/admin-openrc.sh

# Create security group rules to allow ICMP, SSH and WWW access
pfinal_project_id=$(openstack project show pfinal -c id -f value)
pfinal_secgroup_id=$(openstack security group list -f value | grep default | grep $pfinal_project_id | cut -d " " -f1)

wait
openstack security group rule create --proto icmp --dst-port 0 $pfinal_secgroup_id
openstack security group rule create --proto tcp  --dst-port 80 $pfinal_secgroup_id
openstack security group rule create --proto tcp  --dst-port 22 $pfinal_secgroup_id
