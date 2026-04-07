#!/bin/sh
cd zlib-ng-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make

make install
