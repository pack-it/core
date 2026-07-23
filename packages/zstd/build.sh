#!/bin/sh
cd zstd-$PACKIT_PACKAGE_VERSION

make

make test

make install PREFIX="$PACKIT_PACKAGE_PATH"
