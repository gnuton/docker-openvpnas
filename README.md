```
________                     ____   _____________________       _____    _________
\_____  \ ______   ____   ___\   \ /   /\______   \      \     /  _  \  /   _____/
 /   |   \\____ \_/ __ \ /    \   Y   /  |     ___/   |   \   /  /_\  \ \_____  \ 
/    |    \  |_> >  ___/|   |  \     /   |    |  /    |    \ /    |    \/        \
\_______  /   __/ \___  >___|  /\___/    |____|  \____|__  / \____|__  /_______  /
        \/|__|        \/     \/                          \/          \/        \/ 
```        
#OpenVPN Access Server
Pull it from: [`gnuton/openvpnas`](https://hub.docker.com/r/gnuton/openvpnas/)!!

Openvpn Access Server canned in an Ubuntu 16.04 container.
Features:
* OpenVPN AS updated to latest release at each build
* Valid HTTPs certificates using letsencrypt (no automatic update after 30 days yet)
* Volumes persists configuration across image updates and container re-starts 

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
make start
```
4. Wait a a few seconds and let the letsencrypt get the SSL certificates.
5. Check the status of the service with 
```
make status
```

##Configuration
Point your broswer to ```https://vpn.yourdomain.org```
Enter your credential (username: openvpn, password: the one you chose in $PSWD)
Go to Configuration > Server Network Settings > Enter your Hostname or IP Address

You can select the authentication method (Local/PAM/Radius). PAM is the default one.
You can switch to local and add new users through the web interface if you like it.

##Usage
OpenVPN AS exposes configuration which can be automatically imported by OpenVPN clients
through the server at https://vpn.yourdomain.org

##Persistent storage
OpenVPN AS and its configuration get stored in a volume called ovpnas. The SSL certificates go in the volume sslcerts.
If you delete those volumes your clients need to re-import the configurations and this is something you do not want to.
"docker volume ls".
Note that as for now letsencrypt provides max 5 certificates requests in a week. For this reason storing the certificates is needed and will allow you to restart the container multiple times.
The cofiguration OpenVPN AS configuration is stored in /var/lib/docker/volumes/ovpnas/_data/etc/ of the host in case you wanna change it manually.

##Stopping 
"make stop" will send a SIGTERM to the OpenVPN in docker and will wait for it to terminate. When terminated the container will be removed and the volumes will be de-attached and preserved for the next run.

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

##Reference
* https://docs.openvpn.net/docs/access-server/openvpn-access-server-command-line-tools.html#access-server-daemon-status-and-control

