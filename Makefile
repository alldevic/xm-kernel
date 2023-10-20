#!/usr/bin/make

.PHONY: build run
.DEFAULT_GOAL := run

SHELL = /bin/bash

build:
	docker build -t xm .

run: build
	docker run --rm -it -v ./assets/:/assets/ xm:latest
