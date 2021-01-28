#!/bin/sh

. shell_scripts/credentials_g3.sh

create_or_delete=true
while [ ${create_or_delete} = true ]
read -p "Do you want to create or remove a server stack(C/R) or exit(0)? " cr
do
if [ $cr = 'C' ] || [ $cr = 'c' ];
then
	#Create
	read -p "What name to the stack?" stack_name

	read -p "What name to the server?" server_name

	echo "Creating stack "$stack_name" including "$server_name" server"
	openstack stack create -t ./yaml/create_new_server.yml \
		--parameter server_name="$server_name" "$stack_name"
	create_or_delete=false

elif [ $cr = 'R' ] || [ $cr = 'r' ];
then
	read -p "What is name of the stack?" stack_name
	openstack stack delete $stack_name
	create_or_delete=false

elif [ $cr = '0' ];
then
	create_or_delete=false
	exit

else
	echo "O una C o una R, no es tan complicado"

fi

done
