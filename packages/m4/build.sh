#!/bin/sh

./configure --disable-dependency-tracking --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check

make install
