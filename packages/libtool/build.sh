#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules --enable-ltdl-install

make

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check

make install
