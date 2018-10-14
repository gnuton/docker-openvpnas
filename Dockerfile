FROM ubuntu:16.04
MAINTAINER Antonio Aloisio "gnuton@gnuton.org"
MAINTAINER Scott Coulton "https://github.com/scotty-c/docker-openvpn"

USER root
WORKDIR / 

COPY rel/update.sh /
COPY rel/run.sh /
COPY rel/vpn-cert.ini /etc/letsencrypt/vpn-cert.ini
COPY rel/vpn-cert.ini /etc/letsencrypt/vpn-cert.ini

RUN chmod +x /update.sh && apt-get update && apt-get install -y curl wget iptables net-tools letsencrypt && ./update.sh && chmod +x /run.sh

EXPOSE 80/tcp 443/tcp 1194/udp 943/tcp

VOLUME ["/usr/local/openvpn_as", "/etc/letsencrypt"]

CMD ["/run.sh"]

