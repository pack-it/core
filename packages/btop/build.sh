#!/bin/sh

cmake -S . -B build \
    -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTING=OFF

cmake --build build --parallel $PACKIT_BUILD_JOBS_COUNT

cmake --install build
