#Openvpn Access Server
gnuton/openvpnas

A Openvpn Access Server running in a Ubuntu 16.04 docker container.

[`gnuton/openvpnas`](https://registry.hub.docker.com/u/gnuton/openvpn/)

##Running
Get the Makefile from this repo, export PSWD=mypassword and run 'make run'.
In case you want to start the container at boot time run 'make run-atboot'

##Building
```
Clone this repo and run 'make'

```

##Usage
Point your broswer to ```https://dockerhostip:943/admin```
Username is openvpn password is the one you set
