#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH \
    --disable-silent-rules \
    --disable-examples-build \
    --with-openssl \
    --with-libz \
    --with-libz-prefix="$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat" \
    --with-libssl-prefix="$PACKIT_PACKAGE_DEPENDENCIES_PATH/openssl"

make -j $PACKIT_BUILD_JOBS_COUNT

make install
