#!/bin/sh

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release

cmake --build build --config Release

ctest --verbose -C Release

cmake --install build --config Release
