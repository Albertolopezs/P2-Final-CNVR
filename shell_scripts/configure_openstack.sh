#!/bin/sh

extNIC=${1}

echo "Creating security group 'open'..."
openstack security group create --description "Practica final" \
--project pfinal --project-domain default open

#Ingress
openstack security group rule create \
--ingress --description "Allow all ingress" \
--project pfinal --project-domain default open
#Egress
openstack security group rule create open \
--egress --description "Allow all egress" \
--project pfinal --project-domain default

sudo vnx_config_nat ExtNet ${extNIC}


