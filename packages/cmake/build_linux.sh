#!/bin/sh
cd "cmake-$PACKIT_PACKAGE_VERSION"

./bootstrap \
    --prefix="$PACKIT_PACKAGE_PATH" \
    --no-system-libs \
    --no-debugger

make

make install
