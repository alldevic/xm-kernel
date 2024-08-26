#!/usr/bin/make

.PHONY: build run clean
.DEFAULT_GOAL := run

SHELL = /bin/bash

DOCKER_RUN = docker run --rm -it
KCONFIG=-v ./config:/kernel/linux/config:rw

build:
	time docker build -t xm .

run: build
	time $(DOCKER_RUN) -v ./assets/:/kernel/assets/ $(KCONFIG) xm:latest

clean:
	rm -rf assets/*
	touch assets/.gitkeep

oldconfig: build
	time $(DOCKER_RUN) $(KCONFIG) xm:latest make -j16 oldconfig

menuconfig: build
	$(DOCKER_RUN) $(KCONFIG) xm:latest make -j16 menuconfig
