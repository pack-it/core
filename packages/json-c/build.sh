#!/bin/sh

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=ON \
    -DBUILD_APPS=OFF \
    -DBUILD_TESTING=ON

cmake --build build --config Release --parallel $PACKIT_BUILD_JOBS_COUNT

# The `test_json_parse_cli` can't work when `BUILD_APPS` is OFF
ctest --verbose -C Release --test-dir build -E "test_json_parse_cli" --parallel $PACKIT_BUILD_JOBS_COUNT

cmake --install build --config Release
