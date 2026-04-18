#!/bin/sh
cd "cmake-$PACKIT_PACKAGE_VERSION"

./bootstrap \
    --prefix="$PACKIT_PACKAGE_PATH" \
    --no-system-libs \
    --no-debugger \
    --system-zlib \
    --system-bzip2 \
    --system-curl

make

make install
