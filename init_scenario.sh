#!/bin/sh
#Include getopt argparser 
extNIC=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 &&pwd )"


echo "Step 1 - Downloading OpenStack stein"
sh shell_scripts/download_openstack.sh

echo "Step x - Initializing Openstack resources"
sh shell_scripts/init_OpenStack.sh $DIR

echo "Step 2 - Creating new user and project"
. shell_scripts/credentials.sh #Necesitamos credenciales
sh shell_scripts/create_new_user.sh

. ./shell_scripts/credentials_g3.sh
echo "Step 3 - Creating security groups"
sh shell_scripts/configure_openstack.sh $extNIC


echo "- Step 4 - Creating Stack with standar configuration."

openstack stack create -t ./yaml/prueba_servers.yml --parameter "public_network_id=ExtNet" --parameter "admin_server_port=22" stack1

echo "- Step x - Creating and configuring firewall"

sh shell_scripts/create_firewall.sh 22
