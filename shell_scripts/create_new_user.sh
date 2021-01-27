#!bin/sh

#A new project and user is created using the default domain
openstack project create --domain default --description "Practica final" pfinal
openstack user create --domain default --project pfinal --password=xxxx g3
#User is linked with the project through the role
openstack role create alumno
openstack role add --project pfinal --user g3 alumno
