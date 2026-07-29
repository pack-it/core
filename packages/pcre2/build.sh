#!/bin/sh
cd pcre2-$PACKIT_PACKAGE_VERSION

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    extra_flags="--enable-pcre2test-libedit"
fi

./configure --prefix=$PACKIT_PACKAGE_PATH \
    --enable-pcre2-16 \
    --enable-pcre2-32 \
    --enable-pcre2grep-libz \
    --enable-pcre2grep-libbz2 \
    --enable-jit="auto" \
    --disable-dependency-tracking \
    $extra_flags

make

make install
