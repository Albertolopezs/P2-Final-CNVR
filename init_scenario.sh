#!/bin/sh
#Include getopt argparser 
extNIC=$1
customPort=$2

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 &&pwd )"


echo "Step 1 - Downloading OpenStack stein"
sh shell_scripts/download_openstack.sh

echo "Step x - Initializing Openstack resources"
sh shell_scripts/init_OpenStack.sh $DIR

echo "Step 2 - Creating new user and project"
. shell_scripts/credentials.sh #Necesitamos credenciales
sh shell_scripts/create_new_user.sh


echo "Step 3 - Creating security groups"
sh shell_scripts/configure_openstack.sh $extNIC

. ./shell_scripts/credentials_g3.sh
echo "- Step 4 - Creating Stack with standar configuration."

openstack stack create -t ./yaml/init_scenario.yml --parameter "public_network_id=ExtNet" --parameter "admin_server_port=22" stack1

echo "- Step x - Creating and configuring firewall"

if [ "$customPort" = '']
then
	sh shell_scripts/create_firewall.sh 22
else
	sh shell_scripts/create_firewall.sh "$customPort"
fi
