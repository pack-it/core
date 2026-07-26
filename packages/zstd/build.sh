#!/bin/sh
cd zstd-$PACKIT_PACKAGE_VERSION

cmake -S build/cmake -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DBUILD_SHARED_LIBS=ON \
    -DZSTD_PROGRAMS_LINK_SHARED=ON \
    -DZSTD_BUILD_CONTRIB=ON \
    -DZSTD_LEGACY_SUPPORT=ON \
    -DCMAKE_INSTALL_RPATH="$PACKIT_PACKAGE_PATH/lib" \
    -DZSTD_ZLIB_SUPPORT=ON \
    -DZSTD_LZMA_SUPPORT=ON \
    -DZSTD_LZ4_SUPPORT=ON \
    -DCMAKE_CXX_STANDARD=11

cmake --build build --config Release

ctest --verbose -C Release

cmake --install build
