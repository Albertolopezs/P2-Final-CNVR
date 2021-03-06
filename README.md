# Despliegue automático de una aplicación escalable sobre una nube OpenStack utilizando los servicios de orquestación de Heat

El objetivo de esta práctica es el despliegue de una arquitectura de red en el servicio IaaS Openstack (OS). El sistema estará formado por un conjunto de servidores distribuidos, un balanceador de carga para repartir la carga entre dichos servidores, un servidor que actúa como base de datos, un servidor de administración para tareas de gestión y un firewall para garantizar la seguridad de la red entre otros componentes. A su vez, el sistema se ha diseñado para que sea escalable, es decir, que puedan añadirse más servidores para garantizar el funcionamiento en caso de que sea necesario ampliar la red.

## Equipo

Esta práctica ha sido desarrollada por el grupo 3, cuyos miembros son:
- Alberto López Santiago
- Álvaro de Pablo Marsal
- Alejandro Pérez Parra

## Ejecución

Para desplegar la arquitectura de OpenStack, desde uno de los equipos del laboratorio ejecutar.

`$ sh init_scenario.sh <interfaz-externa> <custom-ssh-port>`

Siendo <interfaz-externa> el nombre de la interfaz del equipo que tiene acceso a Internet. Esta interfaz tiene asociada una dirección IP de la red 138.4.X.X y, según estándares de Ubuntu suele ser *enp1s0* o *enp2s0*. Y <custom-ssh-port> el puerto que deseamos utilizar para el acceso por ssh al servidor del administrador. Si no se aporta este parámetro se utilizará por defecto el puerto 22.
  *Esta funcionalidad no ha sido probada*

## Topología

![Topología de red](/img/Topology.png)

## Licencia

Este proyecto está bajo la licencia MIT, cualquier mejora es bienvenida.
