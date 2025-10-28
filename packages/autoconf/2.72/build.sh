#!/bin/sh
cd autoconf-2.72

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install
