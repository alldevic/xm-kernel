#! /bin/bash

make -j32 bindeb-pkg
cp ../linux-* /kernel/assets/
