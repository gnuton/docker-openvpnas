#Openvpn Access Server
gnuton/openvpnas

A Openvpn Access Server running in a Ubuntu 16.04 docker container.
Features:
* Updated OpenVPN AS deb at each build
* Valid HTTPs certificates using letsencrypt
* Default setting use local users authentications. Users can be added through the web interface.
* Makefile simplify docker commands for running, building, get into the container and cleaning. 


[`gnuton/openvpnas`](https://registry.hub.docker.com/u/gnuton/openvpn/)

##How to run
1. Download the  [`Makefile`](https://raw.githubusercontent.com/gnuton/docker-openvpnas/master/Makefile)
2. Export password, domain name and your email as follow 
```
export PSWD=mypassword
export EMAIL=your@email.org
export DOMAIN=vpn.yourdomain.org
```
3. Run the OpenVPN AS as daemon and being restarted after a machine reboot
```
make run-atboot
```
4. Wait a a few seconds and let the letsencrypt get the SSL certificates.
5. Check the status of the service with 
```
make status
```


##Usage
Point your broswer to ```https://vpn.yourdomain.org```
Username is openvpn password is the one you set
You can add more users from the webui.
Clients can fetch configuration from the https server too.

##Stopping and cleaning 
You can kill the container and remove its content with a make stop
```
make stop
```

##Debugging
You can get into a running container by using
```
make attach
```
and you can get the logs running
```
make logs
```

##Building
Clone this repo and run 'make'

##Getting into a running container
make attach

##Reference
* https://docs.openvpn.net/docs/access-server/openvpn-access-server-command-line-tools.html#access-server-daemon-status-and-control

