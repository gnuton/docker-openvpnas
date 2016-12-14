NAME = gnuton/openvpnas
VERSION = 0.1
.PHONY: all build tag_latest

build:
	 docker build -t $(NAME):$(VERSION) . 

test:
	echo "Please write a test"

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

run:
	docker run -d -p 443:443 -p 943:943 -p 1194:1194/udp --privileged=true --name openvpnas $(NAME)

