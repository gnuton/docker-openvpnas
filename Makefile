NAME = gnuton/openvpnas
VERSION = 0.14
PORTS = -p 80:80 -p 443:443 -p 943:943 -p 1194:1194/udp
OVPN_PATH = /usr/local/openvpn_as
CERTS_PATH = /etc/letsencrypt
VOL_OVPN = ovpnas2
VOL_CERTS = sslcerts2

.PHONY: all build

build:
	docker build -t $(NAME):$(VERSION) . 
	docker tag $(NAME):$(VERSION) $(NAME):latest
attach:
	docker exec -it $$(docker ps -aqf "name=openvpnas") bash

logs:
	docker logs $$(docker ps -aqf "name=openvpnas")

rm:
	docker rm $$(docker ps -aqf "name=openvpnas")

rm-orphan-volumes:
	docker volume rm `docker volume ls -q -f dangling=true`

start: run
stop: stop-instance rm list-volumes

stop-instance:
	docker stop $$(docker ps -aqf "name=openvpnas")

list-volumes:
	docker volume ls

status:
	docker exec -it $$(docker ps -aqf "name=openvpnas") /usr/local/openvpn_as/scripts/sacli status

run: check-env
	docker run -v $(VOL_OVPN):$(OVPN_PATH) -v $(VOL_CERTS):$(CERTS_PATH) \
                   -h $(DOMAIN) \
                   -e "PSWD=$(PSWD)" -e "EMAIL=$(EMAIL)" -e "DOMAIN=$(DOMAIN)" \
                   -d $(PORTS) \
                   --privileged=true \
                   --name openvpnas \
		   --restart=always \
                   $(NAME):latest

check-env: check-pswd check-email check-domain

check-pswd:
ifndef PSWD
       $(error PSWD is undefined: Please run 'export PSWD=mypassword' before running a make run)
endif

check-email:
ifndef EMAIL
	$(error EMAIL is undefined: Please run 'export EMAIL=your@email.org' before running a make run)
endif

check-domain:
ifndef DOMAIN
        $(error DOMAIN is undefined: Please run 'export DOMAIN=vpn.domain.org' before running a make run)
endif
