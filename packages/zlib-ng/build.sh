#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --installnamedir="$PACKIT_PACKAGE_PATH/lib"

make -j $PACKIT_BUILD_JOBS_COUNT

make install
