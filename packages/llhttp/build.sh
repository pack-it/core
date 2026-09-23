#!/bin/sh

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release

cmake --build build --config Release --parallel $PACKIT_BUILD_JOBS_COUNT

# Only supports testing with node based tools

cmake --install build --config Release
