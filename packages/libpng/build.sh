#!/bin/sh
cd libpng-$PACKIT_PACKAGE_VERSION

if [ "$PACKIT_OS" = "macos" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH
else
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include" \
        LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz"
fi


make

make test

make install
