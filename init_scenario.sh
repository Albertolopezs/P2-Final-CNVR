#!/bin/sh
#Include getopt argparser 
extNIC=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 &&pwd )"
echo "Step 1 - Downloading OpenStack stein"
cp shell_scripts/init_OpenStack.sh /mnt/tmp/.
sh /mnt/tmp/init_OpenStack.sh $DIR $extNIC




echo "- Step 4 - Creating Stack with standar configuration."
openstack stack create -t prueba_servers.yml --parameter "public_network_id=ExtNet" --parameter "admin_server_port=22" stack1

