#!/bin/sh

. shell_scripts/credentials_g3.sh

create_or_delete=true
while [ ${create_or_delete} = true ]
read -p "Do you want to enable or disable SSH to the Admin server(E/D) or exit(0)? " ed
do
if [ "$ed" = 'E' ] || [ "$ed" = 'e' ];
then
	#Enable
	openstack firewall group policy add rule \
	--insert-before lbWWW \
	ingressPolicy \
	adminSSH
	echo "Done."
	create_or_delete=false

elif [ "$ed" = 'D' ] || [ "$ed" = 'd' ];
then
	openstack firewall group policy remove rule \
	ingressPolicy \
	adminSSH
	echo "Done."
	create_or_delete=false

elif [ "$ed" = '0' ];
then
	create_or_delete=false
	exit

else
	echo "O una E o una D, no es tan complicado"

fi

done
