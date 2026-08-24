#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules --enable-ltdl-install

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check

make install
