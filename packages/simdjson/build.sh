#!/bin/sh

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_INSTALL_RPATH="$PACKIT_PACKAGE_PATH/lib" \
    -DCMAKE_BUILD_TYPE=Release

cmake --build build --config Release --parallel $PACKIT_BUILD_JOBS_COUNT

# Developer mode is necessary to run the build tests (All build tests pass on v5.1.0)

cmake --install build --config Release
