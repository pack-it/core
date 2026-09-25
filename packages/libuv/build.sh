#!/bin/sh 

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

# TODO: Make check doesn't work reliably
[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install
