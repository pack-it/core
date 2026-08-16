#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make

make install
