FROM ubuntu:16.04
MAINTAINER Antonio Aloisio "gnuton@gnuton.org"
MAINTAINER Scott Coulton "https://github.com/scotty-c/docker-openvpn"

USER root
WORKDIR / 

COPY rel/update.sh /
RUN chmod +x /update.sh
RUN apt-get update && apt-get install -y curl wget iptables net-tools letsencrypt && ./update.sh

COPY rel/run.sh /
RUN chmod +x /run.sh

COPY rel/vpn-cert.ini /etc/letsencrypt/vpn-cert.ini

EXPOSE 443/tcp 1194/udp 943/tcp

VOLUME ["/usr/local/openvpn_as", "/etc/letsencrypt"]

CMD ["/run.sh"]

