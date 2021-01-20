#!bin/sh
ExtNETVar = "$1"

echo "- Initializing OpenStack -"

echo "- Step 1 - Downloading Scenario"
/lab/cnvr/bin/get-openstack-tutorial.sh
sudo vnx --unpack openstack_lab-stein_4n_classic_ovs-v06
cd openstack_lab-stein_4n_classic_ovs-v06

echo "- Step 2 - Creating OS scenario"
sudo vnx -f openstack_lab.xml --create

echo "- Step 3 - Configuring scenario"
sudo vnx -f openstack_lab.xml -v -x start-all,load-img
sudo vnx_config_nat ExtNet enp2s0

export OS_USERNAME=admin
export OS_PASSWORD=xxxx
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3

