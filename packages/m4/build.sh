#!/bin/sh

./configure --disable-dependency-tracking --prefix=$PACKIT_PACKAGE_PATH

make

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check

make install
