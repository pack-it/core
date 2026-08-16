#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --zlib-compat --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make

make install
