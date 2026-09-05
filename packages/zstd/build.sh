#!/bin/sh

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    lib_extension="dylib"
elif [ "$PACKIT_OS" = "linux" ]; then
    lib_extension="so"

    extra_flags="$extra_flags -DZLIB_LIBRARY=$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib/libz.so"
    extra_flags="$extra_flags -DZLIB_INCLUDE_DIR=$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include"
    extra_flags="$extra_flags -DLIBLZMA_LIBRARY=$PACKIT_PACKAGE_DEPENDENCIES_PATH/xz/lib/liblzma.so"
fi

cmake -S build/cmake -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DZSTD_PROGRAMS_LINK_SHARED=ON \
    -DZSTD_BUILD_CONTRIB=ON \
    -DZSTD_LEGACY_SUPPORT=ON \
    -DCMAKE_INSTALL_RPATH="$PACKIT_PACKAGE_PATH/lib" \
    -DZSTD_ZLIB_SUPPORT=ON \
    -DZSTD_LZMA_SUPPORT=ON \
    -DLIBLZMA_INCLUDE_DIR="$PACKIT_PACKAGE_DEPENDENCIES_PATH/xz/include" \
    -DZSTD_LZ4_SUPPORT=ON \
    -DLIBLZ4_INCLUDE_DIR="$PACKIT_PACKAGE_DEPENDENCIES_PATH/lz4/include" \
    -DLIBLZ4_LIBRARY="$PACKIT_PACKAGE_DEPENDENCIES_PATH/lz4/lib/liblz4.$lib_extension" \
    -DCMAKE_CXX_STANDARD=11 \
    $extra_flags
    

cmake --build build --config Release

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && ctest -C Release

cmake --install build --config Release
