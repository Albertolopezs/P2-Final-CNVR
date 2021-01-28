#!bin/sh

customPort=$1

#Floating IPs
LB_FIP=$(openstack stack output show stack1 LoadBalancer_private_ip -f value -c output_value)
AdminServer_FIP=$(openstack stack output show stack1 AdminServer_private_ip -f value -c output_value)

while [ "${LB_FIP}" = 'None' ] || [ "${LB_FIP}" = '' ] || [ "${AdminServer_FIP}" = 'None' ] || [ "${AdminServer_FIP}" = '' ]
do
echo "Esperando a que se configure el escenario"
sleep 10
LB_FIP=$(openstack stack output show stack1 LoadBalancer_private_ip -f value -c output_value)
AdminServer_FIP=$(openstack stack output show stack1 AdminServer_private_ip -f value -c output_value)
done
echo "Load Balancer internal IP: ${LB_FIP}"
echo "Admin Server internal IP: ${AdminServer_FIP}"

#Ingress to Adminserver at {CustomPort} (SSH)
openstack firewall group rule create \
--protocol tcp --destination-ip-address ${AdminServer_FIP} \
--destination-port ${customPort}:${customPort} \
--action allow \
--name adminSSH

#Ingress to LoadBalancer at WWW (80) Port

openstack firewall group rule create \
--protocol tcp --destination-ip-address ${LB_FIP} \
--destination-port 80:80 \
--action allow \
--name lbWWW


#Egress to any direction

openstack firewall group rule create \
--protocol any --source-ip-address 10.0.11.0/24 \
--action allow \
--name egressAllNet1

openstack firewall group rule create \
--protocol any --source-ip-address 10.0.12.0/24 \
--action allow \
--name egressAllNet2

#Ingress default rejection
openstack firewall group rule create \
--protocol any \
--action reject \
--name rejectIngress

#Create ingress and egress policy

openstack firewall group policy create \
--firewall-rule lbWWW \
--firewall-rule rejectIngress \
ingressPolicy

openstack firewall group policy create \
--firewall-rule egressAllNet1 \
--firewall-rule egressAllNet2 \
egressPolicy


#Create firewall group

routerPort=$(openstack port list --fixed-ip ip-address=10.0.11.1 -c ID -f value)
openstack firewall group create \
--ingress-firewall-policy ingressPolicy \
--egress-firewall-policy egressPolicy \
--port ${routerPort} \
--name g3Firewall



