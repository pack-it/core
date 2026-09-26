#!/bin/sh 

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

# Skip libuv tests, because some are unreliable.

make install
