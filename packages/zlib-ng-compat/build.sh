#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --zlib-compat --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make

# -B is necessary to force testing, otherwise it doesn't test if the source hasn't changed
make -B test

make install
