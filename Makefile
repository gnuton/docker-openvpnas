NAME = gnuton/openvpnas
VERSION = 0.1

.PHONY: all build tag_latest

build:
	 docker build -t $(NAME):$(VERSION) . 

test:
	echo "Please write a test"

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest
