#!/bin/sh
cd zlib-ng-compat-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --zlib-compat="ON"

make

make install
