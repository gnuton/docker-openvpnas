NAME = gnuton/openvpnas
VERSION = 0.1
PORTS = -p 443:443 -p 943:943 -p 1194:1194/udp


.PHONY: all build tag_latest

build:
	docker build -t $(NAME):$(VERSION) . 

test:
	echo "Please write a test"

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

run: check-env
	docker run -e "PSWD=$(PSWD)" -d $(PORTS) --privileged=true --name openvpnas $(NAME):$(VERSION)

run-atboot: check-env
	docker run -e "PSWD=$(PSWD)" --restart=always -d $(PORTS) --privileged=true --name openvpnas $(NAME):$(VERSION)

check-env:
ifndef PSWD
	$(error PSWD is undefined: Please run 'export PSWD=mypassword' before running a make run)
endif
