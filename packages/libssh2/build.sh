#!/bin/sh

# Disable tests which require docker and sshd which don't work when `--disable-docker-tests` is enabled
# Note that the sshd tests do work when docker tests are not disabled.
./configure --prefix=$PACKIT_PACKAGE_PATH \
    --disable-silent-rules \
    --disable-examples-build \
    --disable-docker-tests \
    --disable-sshd-tests \
    --with-openssl \
    --with-libz \
    --with-libz-prefix="$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat" \
    --with-libssl-prefix="$PACKIT_PACKAGE_DEPENDENCIES_PATH/openssl"

make

make check

make install
