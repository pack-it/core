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
fi

if [ "$PACKIT_OS" = "linux" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        $flags \
        --enable-pcre2test-libreadline \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include -I$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/include -I$PACKIT_PACKAGE_DEPENDENCIES_PATH/readline/include" \
        LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz -L$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/lib -lbz2 -L$PACKIT_PACKAGE_DEPENDENCIES_PATH/readline/lib -lreadline"
fi

make

make install
