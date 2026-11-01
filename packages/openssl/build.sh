#!/bin/sh

unset OPENSSL_LOCAL_CONFIG_DIR

perl ./Configure \
    --prefix=$PACKIT_PACKAGE_PATH \
    --openssldir=$PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION \
    --libdir=lib \

make -j $PACKIT_BUILD_JOBS_COUNT

[ "$PACKIT_EXECUTE_BUILD_TEST" = "1" ] && make HARNESS_JOBS=$PACKIT_BUILD_JOBS_COUNT test -j $PACKIT_BUILD_JOBS_COUNT

# Install openssl
make install_sw
make install_man_docs

# Install ssldir to a path inside the package
make install_ssldirs OPENSSLDIR=$PACKIT_PACKAGE_PATH/.external/etc/openssl@$PACKIT_PACKAGE_VERSION
