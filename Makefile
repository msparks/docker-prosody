all: prosody
.PHONY: all

prosody:
	docker build -t msparks/prosody .
.PHONY: prosody
