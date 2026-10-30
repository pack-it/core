#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --enable-shared --enable-static

make -j $PACKIT_BUILD_JOBS_COUNT

# Tests require gmock

make install
