#!/bin/sh

unset OPENSSL_LOCAL_CONFIG_DIR

perl ./Configure \
    --prefix=$PACKIT_PACKAGE_PATH \
    --openssldir=$PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION \
    --libdir=lib \

make -j $PACKIT_BUILD_JOBS_COUNT

make HARNESS_JOBS=$PACKIT_BUILD_JOBS_COUNT test -j $PACKIT_BUILD_JOBS_COUNT

make install
