#!/bin/sh

if [ ! -e "$PACKIT_PACKAGE_PATH/cacert.pem" ]; then
    echo "Test failed: cacert.pem file cannot be found"
    exit 1
fi

if [ ! -e "$PACKIT_PACKAGE_PATH/cert.pem" ]; then
    echo "Test failed: cert.pem file cannot be found"
    exit 1
fi
