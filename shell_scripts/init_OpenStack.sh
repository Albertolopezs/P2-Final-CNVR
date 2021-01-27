#!bin/sh
projectPath=${1}

# "Copying Openstack.xml"
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06
cp ${projectPath}/xml/openstack_lab.xml .

# "Launching openstack"
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -v -x start-all,load-img


