#!/bin/sh 

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# TODO: Make check doesn't work reliably
make check

make install
