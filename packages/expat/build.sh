#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --mandir="$PACKIT_PACKAGE_PATH/share/man"

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_INCLUDE_BUILD_TEST:-}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install
