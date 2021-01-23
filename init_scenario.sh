#!/bin/sh
#Include getopt argparser 
extNIC=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 &&pwd )"

source shell_scripts/credentials.sh #Executes in the current shell, modifying the credentials. Don't use sh

echo "Step 1 - Downloading OpenStack stein"
cp shell_scripts/init_OpenStack.sh /mnt/tmp/.
cp serverSS.qcow2 /mnt/tmp/.
sh /mnt/tmp/init_OpenStack.sh $DIR $extNIC
rm -f /mnt/tmp/init_OpenStack.sh



echo "- Step 4 - Creating Stack with standar configuration."
openstack stack create -t ./yaml/prueba_servers.yml --parameter "public_network_id=ExtNet" --parameter "admin_server_port=22" stack1

#echo " - Step X - Configuring access and security."
#cp shell_scripts/configure_security.sh /mnt/tmp/.
#rm -f /mnt/tmp/configure_security.sh

