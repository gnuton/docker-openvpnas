FROM ubuntu:16.04
MAINTAINER Scott Coulton "https://github.com/scotty-c/docker-openvpn"
MAINTAINER Antonio Aloisio "gnuton@gnuton.org"

USER root
WORKDIR / 

COPY rel/update.sh /
RUN chmod +x /update.sh
RUN apt-get update && apt-get install -y curl wget iptables net-tools  && ./update.sh

COPY rel/run.sh /
RUN chmod +x /run.sh

EXPOSE 443/tcp 1194/udp 943/tcp

VOLUME ["/usr/local/openvpn_as"]

CMD ["/run.sh"]

