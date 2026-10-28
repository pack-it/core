#!/bin/sh

# Build static
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_INSTALL_RPATH="$PACKIT_PACKAGE_PATH/lib" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF

cmake --build build-static --config Release --parallel $PACKIT_BUILD_JOBS_COUNT

[ "$PACKIT_EXECUTE_BUILD_TEST" = "1" ] && ctest -C Release --test-dir build-static --parallel $PACKIT_BUILD_JOBS_COUNT

cmake --install build-static --config Release

# Build shared
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_INSTALL_RPATH="$PACKIT_PACKAGE_PATH/lib" \
    -DCMAKE_BUILD_TYPE=Release

cmake --build build --config Release --parallel $PACKIT_BUILD_JOBS_COUNT

[ "$PACKIT_EXECUTE_BUILD_TEST" = "1" ] && ctest -C Release --test-dir build --parallel $PACKIT_BUILD_JOBS_COUNT

cmake --install build --config Release
