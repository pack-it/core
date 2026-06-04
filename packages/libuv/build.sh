#!/bin/sh 

cd "libuv-$PACKIT_PACKAGE_VERSION"

cmake -B build -S . \
    -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH"

cmake --build build

cmake --install build