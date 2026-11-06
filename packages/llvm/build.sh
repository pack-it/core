#!/bin/sh

cmake -S llvm -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_BUILD_TYPE=Release

cmake --build build --config Release

[ "$PACKIT_EXECUTE_BUILD_TEST" = "1" ] && cd llvm && make check -j1

cmake --install build --config Release
