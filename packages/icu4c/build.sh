#!/bin/sh
cd source

./configure --prefix=$PACKIT_PACKAGE_PATH \
    --disable-samples \
    --enable-static \
    --enable-shared \
    --enable-rpath \
    --with-library-bits=64

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_INCLUDE_BUILD_TEST:-}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install
