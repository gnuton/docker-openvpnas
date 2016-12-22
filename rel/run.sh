#!/bin/bash
echo "openvpn:$PSWD" | chpasswd

#cleaning old tmp
rm /usr/local/openvpn_as/etc/tmp/* -Rf

sed -i -- 's/vpn.server.com/'"$DOMAIN"'/g' /etc/letsencrypt/vpn-cert.ini
sed -i -- 's/server@server.com/'"$EMAIL"'/g' /etc/letsencrypt/vpn-cert.ini

# Get SSL certificates. You can request 5 certs in 7 days. If you exceed it openvpn as will fall back to self signed ones
if [ ! -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]; then
  echo "No certificates found. Fetching..."
  letsencrypt certonly -c /etc/letsencrypt/vpn-cert.ini --renew-by-default --text
fi
if [ -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]; then
  echo "Setting up SSL certificates.."
  /usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle -v "`cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem`"
  /usr/local/openvpn_as/scripts/confdba -mk cs.priv_key -v "`cat /etc/letsencrypt/live/$DOMAIN/privkey.pem`" > /dev/null
  /usr/local/openvpn_as/scripts/confdba -mk cs.cert -v "`cat /etc/letsencrypt/live/$DOMAIN/cert.pem`"
fi

# remove twisted pid
if ps -p $(cat twistd.pid) > /dev/null 2>&1
then
    kill $(cat twistd.pid)
    /usr/local/openvpn_as/scripts/openvpnas -n
    exit 0
else
    echo "no twistd.pid found"   
fi

# remove pid file if it exists
if [ -e "/var/run/openvpnas.pid" ]; then
  rm -f "/var/run/openvpnas.pid" &>/dev/null
fi

# Create base config for OpenVPN AS
#/usr/local/openvpn_as/bin/ovpn-init --host=$DOMAIN --local_auth --batch --force --no_start

# Start OpenVPN
/usr/local/openvpn_as/scripts/openvpnas -n
