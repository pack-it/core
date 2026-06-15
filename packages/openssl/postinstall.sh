#!/bin/sh
if [ -e "$PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION/certs/cert.pem" ]; then
    rm "$PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION/certs/cert.pem"
fi

ln -sf $PACKIT_PACKAGE_DEPENDENCIES_PATH/ca-certificates/cert.pem $PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION/certs/cert.pem
