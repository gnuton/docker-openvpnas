NAME = gnuton/openvpnas
VERSION = 0.2
PORTS = -p 443:443 -p 943:943 -p 1194:1194/udp


.PHONY: all build tag_latest

build:
	docker build -t $(NAME):$(VERSION) . 

attach:
	docker exec -it $$(docker ps -aqf "name=openvpnas") bash

test:
	echo "Please write a test"

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

run: check-env
	docker run -e "PSWD=$(PSWD)" -e "EMAIL=$(EMAIL)" -e "DOMAIN=$(DOMAIN)" -d $(PORTS) --privileged=true --name openvpnas $(NAME):$(VERSION)

run-atboot: check-env
	docker run -e "PSWD=$(PSWD)" --restart=always -d $(PORTS) --privileged=true --name openvpnas $(NAME):$(VERSION)

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
        $(error DOMAIN is undefined: Please run 'export DOMAIN=vpn.yourdomain.org' before running a make run)
endif
