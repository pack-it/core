#!/bin/sh
cd htop-3.4.1

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install
