#!/bin/sh

ln -sf $PACKIT_PREFIX_PATH/dependencies/openssl@$PACKIT_PACKAGE_VERSION/ca-certificates/cert.pem $PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION/certs/cert.pem
