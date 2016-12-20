#Openvpn Access Server
gnuton/openvpnas

A Openvpn Access Server running in a Ubuntu 16.04 docker container.
Features:
* Updated OpenVPN AS deb at each build
* Valid HTTPs certificates using letsencrypt
* Makefile simplify docker commands for running, building, get into the container and cleaning. 

[`gnuton/openvpnas`](https://registry.hub.docker.com/u/gnuton/openvpn/)

##Running
Get the Makefile from this repo, export PSWD=mypassword and run 'make run'.
In case you want to start the container at boot time run 'make run-atboot'

##Building
Clone this repo and run 'make'

##Getting into a running container
make attach

##Usage
Point your broswer to ```https://dockerhostip:943/admin```
Username is openvpn password is the one you set

##Reference
* https://docs.openvpn.net/docs/access-server/openvpn-access-server-command-line-tools.html#access-server-daemon-status-and-control

