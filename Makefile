#!/usr/bin/make

.PHONY: build run clean
.DEFAULT_GOAL := run

SHELL = /bin/bash

DOCKER_RUN = docker run --rm -it
KCONFIG=-v ./config:/linux/config:rw

build:
	docker build -t xm .

run: build
	$(DOCKER_RUN) -v ./assets/:/assets/ $(KCONFIG) xm:latest

clean:
	rm -rf assets/*
	touch assets/.gitkeep

oldconfig: build
	$(DOCKER_RUN) $(KCONFIG) xm:latest make -j16 oldconfig

menuconfig: build
	$(DOCKER_RUN) $(KCONFIG) xm:latest make -j16 menuconfig
