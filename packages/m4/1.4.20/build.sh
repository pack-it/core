#!/bin/sh
cd m4-1.4.20

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install
