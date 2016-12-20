#!/bin/bash
echo "openvpn:$PSWD" | chpasswd

sed -i -- 's/vpn.server.com/'"$DOMAIN"'/g' /etc/letsencrypt/vpn-cert.ini
sed -i -- 's/server@server.com/'"$EMAIL"'/g' /etc/letsencrypt/vpn-cert.ini

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

# Get SSL certificates
letsencrypt certonly -c /etc/letsencrypt/vpn-cert.ini --text
/usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle -v "`cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem`"
/usr/local/openvpn_as/scripts/confdba -mk cs.priv_key -v "`cat /etc/letsencrypt/live/$DOMAIN/privkey.pem`" > /dev/null
/usr/local/openvpn_as/scripts/confdba -mk cs.cert -v "`cat /etc/letsencrypt/live/$DOMAIN/cert.pem`"

# Start OpenVPN
/usr/local/openvpn_as/scripts/openvpnas -n
