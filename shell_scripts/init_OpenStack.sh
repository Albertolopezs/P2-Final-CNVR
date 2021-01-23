#!bin/sh
projectPath=${1}
extNIC=${2}


echo "- Initializing OpenStack -"
/mnt/vnx/repo/cnvr/bin/get-openstack-tutorial.sh
echo "- Step 2 - Copying Openstack.xml"
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06
cp ${projectPath}/xml/openstack_lab.xml .

echo "- Step 3 - Configuring scenario and NAT"
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -v -x start-all,load-img,create-security-groups
sudo vnx_config_nat ExtNet ${extNIC}

