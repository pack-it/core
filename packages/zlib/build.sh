#!/bin/sh
cd zlib-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make

make install
