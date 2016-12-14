FROM ubuntu:16.04

MAINTAINER Antonio Aloisio "https://github.com/gnuton/docker-openvpn"

USER root

WORKDIR / 

RUN apt-get update && apt-get install -y curl wget iptables net-tools  && \
    wget http://swupdate.openvpn.org/as/openvpn-as-2.1.2-Ubuntu16.amd_64.deb -O openvpn-as.deb && \ 
    dpkg -i openvpn-as.deb && \
    echo "openvpn:password1234" | chpasswd && \
    rm -rf openvpn-as.deb

COPY build/entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 443/tcp 1194/udp 943/tcp

VOLUME ["/usr/local/openvpn_as"]

CMD ["/entrypoint.sh"]

