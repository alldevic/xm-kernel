#!/usr/bin/make

.PHONY: build run clean
.DEFAULT_GOAL := run

SHELL = /bin/bash
DOCKER_RUN = docker run --rm -it

build:
	docker build -t xm .

run: build
	docker run --rm -it -v ./assets/:/assets/ -v ./.config:/linux/.config xm:latest

clean:
	rm -rf assets/*
	touch assets/.gitkeep

#oldconfig: build
#	$(DOCKER_RUN) -v ./.config:/linux/.config:rw xm:latest make -j16 oldconfig

#menuconfig: build
#	$(DOCKER_RUN) -v ./.config:/linux/.config:rw xm:latest make -j16 menuconfig
