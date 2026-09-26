#!/bin/sh

# NOTE lto NOT on Linux
# The `--enable-optimizations` flag does some platform specific optimizations, so prebuilds might differ depending on architecture.
./configure --prefix=$PACKIT_PACKAGE_PATH \
    --enable-ipv6 \
    --datarootdir="$PACKIT_PACKAGE_PATH/share" \
    --datadir="$PACKIT_PACKAGE_PATH/share" \
    --without-ensurepip \
    --enable-loadable-sqlite-extensions \
    --with-openssl="$PACKIT_PACKAGE_DEPENDENCIES_PATH/openssl" \
    --enable-optimizations \
    --with-system-expat \
    --with-system-libmpdec \
    --with-readline=editline \
    --with-lto \
    LIBLZMA_CFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/xz/include" \
    LIBLZMA_LIBS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/xz/lib -llzma" \
    LIBZSTD_CFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zstd/include" \
    LIBZSTD_LIBS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zstd/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/zstd/lib -lzstd"

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make test -j $PACKIT_BUILD_JOBS_COUNT

make install

ln -s python$PACKIT_ARGS_MAJOR_MINOR_VERSION $PACKIT_PACKAGE_PATH/bin/python
