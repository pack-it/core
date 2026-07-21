#!/bin/sh
cd libpng-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH \
    CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib/include" \
    LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib/lib -lz"

make

make test

make install
