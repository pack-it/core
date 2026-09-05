#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --mandir="$PACKIT_PACKAGE_PATH/share/man"

make

[ "${PACKIT_INCLUDE_BUILD_TEST:-}" = "1" ] && make check

make install
