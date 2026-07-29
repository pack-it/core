#!/bin/sh
cd pcre2-$PACKIT_PACKAGE_VERSION

flags="--enable-pcre2-16 \
        --enable-pcre2-32 \
        --enable-pcre2grep-libz \
        --enable-pcre2grep-libbz2 \
        --enable-jit="auto" \
        --disable-dependency-tracking"

if [ "$PACKIT_OS" = "mac" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        $flags \
        --enable-pcre2test-libedit
else
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        $flags \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include -I$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/include" \
        LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz -L$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/lib -lbz2"
fi


make

make install
