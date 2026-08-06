#!/bin/sh 
cd "libuv-v$PACKIT_PACKAGE_VERSION"

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make check

make install
