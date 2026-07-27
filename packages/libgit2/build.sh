#!/bin/sh
cd libgit2-$PACKIT_PACKAGE_VERSION

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    # The DCMAKE_INSTALL_RPATH is needed because llhttp has an install name containing @rpath
    extra_flags="-DCMAKE_INSTALL_RPATH=\"$PACKIT_PACKAGE_DEPENDENCIES_PATH/llhttp/lib\""
fi

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" \
    -DUSE_HTTP_PARSER=llhttp \
    -DUSE_SSH=ON \
    -DUSE_BUNDLED_ZLIB=OFF \
    $extra_flags

cmake --build build --config Release

ctest --verbose -C Release

cmake --install build
