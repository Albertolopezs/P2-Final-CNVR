#!/bin/sh

extNIC=${1}
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06
sudo vnx -f openstack_lab.xml -v -x load-img,create-security-groups
sudo vnx_config_nat ExtNet ${extNIC}


