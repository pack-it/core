#!/bin/sh
set -e

cd "neovim-$PACKIT_PACKAGE_VERSION"

cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH"

cmake --build build

cmake --install build