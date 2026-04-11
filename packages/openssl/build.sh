#!/bin/sh
cd openssl-$PACKIT_PACKAGE_VERSION

unset OPENSSL_LOCAL_CONFIG_DIR

perl ./Configure \
    --prefix=$PACKIT_PACKAGE_PATH \
    --openssldir=$PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION \
    --libdir=lib \

make

make HARNESS_JOBS=4 test

make install
