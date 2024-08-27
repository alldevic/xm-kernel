#! /bin/bash

make -j`nproc` bindeb-pkg
cp ../linux-* /kernel/assets/
