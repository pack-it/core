#!/bin/sh

cmake -S build/cmake -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DZSTD_PROGRAMS_LINK_SHARED=ON \
    -DZSTD_BUILD_CONTRIB=ON \
    -DZSTD_LEGACY_SUPPORT=ON \
    -DCMAKE_INSTALL_RPATH="$PACKIT_PACKAGE_PATH/lib" \
    -DZSTD_ZLIB_SUPPORT=ON \
    -DZSTD_LZMA_SUPPORT=ON \
    -DZSTD_LZ4_SUPPORT=ON \
    -DCMAKE_CXX_STANDARD=11

cmake --build build --config Release --parallel $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && ctest -C Release --parallel $PACKIT_BUILD_JOBS_COUNT

cmake --install build --config Release
