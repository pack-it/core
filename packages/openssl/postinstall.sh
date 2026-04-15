#!/bin/sh

ln -sf $PACKIT_PACKAGE_DEPENDENCIES_PATH/ca-certificates/cert.pem $PACKIT_PREFIX_PATH/etc/openssl@$PACKIT_PACKAGE_VERSION/certs/cert.pem
