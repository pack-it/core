#!/bin/sh

if [ "$PACKIT_OS" = "mac" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH
fi

if [ "$PACKIT_OS" = "linux" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include" \
        LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz"
fi

make -j $PACKIT_BUILD_JOBS_COUNT

make test -j $PACKIT_BUILD_JOBS_COUNT

make install
