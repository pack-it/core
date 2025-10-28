#!/bin/sh
cd automake-1.18.1

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install
