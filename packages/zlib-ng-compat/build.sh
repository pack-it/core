#!/bin/sh
cd zlib-ng-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --zlib-compat
make

make install
