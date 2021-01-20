#!bin/sh
projectPath=${1}
extNIC=${2}


echo "- Initializing OpenStack -"

echo "- Step 1 - Downloading Scenario"
/lab/cnvr/bin/get-openstack-tutorial.sh
sudo vnx --unpack openstack*.tgz
echo "- Step 2 - Copying Openstack.xml"
cd openstack*/
cp ${projectPath}/xml/openstack_lab.xml .

echo "- Step 3 - Configuring scenario and NAT"
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -v -x start-all,load-img,create-security-groups
sudo vnx_config_nat ExtNet ${extNIC}
