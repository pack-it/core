#!/bin/sh

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# Htop doesn't have a testsuite

make install
