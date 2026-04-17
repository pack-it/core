#!/usr/bin/env sh

cd "cmake-$PACKIT_PACKAGE_VERSION"


./bootstrap \
    --prefix="$PACKIT_PACKAGE_VERSION"
    --no-system-libs \
    --no-debugger

make 
make install