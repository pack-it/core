#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

# TODO: Make check only works when run manually for some reason
[ "${PACKIT_INCLUDE_BUILD_TEST:-}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install
