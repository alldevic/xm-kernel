#!/usr/bin/make

.PHONY: build run clean oldconfig menuconfig sh patch_config
.DEFAULT_GOAL := run

SHELL = /bin/bash

DOCKER_RUN = docker run --rm -it

ASSETS=-v ./assets/:/kernel/assets/
KCONFIG=-v ./config:/kernel/linux/config:rw
PKGVERSION= -v ./KDEB_PKGVERSION:/kernel/linux/.version:rw

BASE_CMD=$(DOCKER_RUN) $(KCONFIG) $(PKGVERSION)

build:
	touch KDEB_PKGVERSION
	docker build -t xm .

run: build
	time $(BASE_CMD) $(ASSETS) xm:latest

clean:
	rm -rf KDEB_PKGVERSION assets/*
	touch assets/.gitkeep

oldconfig: build
	time $(BASE_CMD) xm:latest make -j`nproc` oldconfig

menuconfig: build
	$(BASE_CMD) xm:latest make menuconfig

sh:
	 $(BASE_CMD) xm:latest bash
# Double for fix line ordering
patch_config: oldconfig
	 $(BASE_CMD) xm:latest ./patch_config.sh 
	 $(BASE_CMD) xm:latest ./patch_config.sh
