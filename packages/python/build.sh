#!/bin/sh

set --
if [ "$PACKIT_OS" = "mac" ]; then
    # Note that LTO does NOT work on Linux, libpython3.*.a breaks when the GCC version differs 
    # from the GCC version used for the python build.
    set -- "$@" \
        "--with-lto"
elif [ "$PACKIT_OS" = "linux" ]; then
    set -- "$@" \
        "BZIP2_CFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/include" \
        "BZIP2_LIBS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/bzip2/lib -lbz2" \
        "ZLIB_CFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/include" \
        "ZLIB_LIBS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zlib-ng-compat/lib -lz" \
        "LIBCURSES_CFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/ncurses/include" \
        "LIBCURSES_LIBS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/ncurses/lib -lncurses" \
        "LIBFFI_CFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/libffi/include" \
        "LIBFFI_LIBS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/libffi/lib -lffi" \
        "LIBEDIT_CFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/libedit/include" \
        "LIBEDIT_LIBS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/libedit/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/libedit/lib -ledit" \
        "LIBMPDEC_CFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/mpdecimal/include" \
        "LIBMPDEC_LIBS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/mpdecimal/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/mpdecimal/lib -lmpdec" \
        "CPPFLAGS=-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/expat/include -I$PACKIT_PACKAGE_DEPENDENCIES_PATH/openssl/include" \
        "LDFLAGS=-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/expat/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/expat/lib -lexpat -L$PACKIT_PACKAGE_DEPENDENCIES_PATH/openssl/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/openssl/lib -lssl"
fi

# The `--enable-optimizations` flag does some architecture specific optimizations, so prebuilds might differ depending on architecture.
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
    LIBLZMA_CFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/xz/include" \
    LIBLZMA_LIBS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/xz/lib -llzma" \
    LIBZSTD_CFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/zstd/include" \
    LIBZSTD_LIBS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/zstd/lib -Wl,-rpath,$PACKIT_PACKAGE_DEPENDENCIES_PATH/zstd/lib -lzstd" \
    "$@"

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make test -j $PACKIT_BUILD_JOBS_COUNT

make install

ln -s python$PACKIT_ARGS_MAJOR_MINOR_VERSION $PACKIT_PACKAGE_PATH/bin/python

# Define the site-packages location
PYTHON_OPT="$PACKIT_PREFIX_PATH/opt/python/$PACKIT_ARGS_MAJOR_MINOR_VERSION"
PYTHON_SITE_PACKAGES="$PYTHON_OPT/lib/python$PACKIT_ARGS_MAJOR_MINOR_VERSION/site-packages"
mkdir -p $PYTHON_OPT

# Create sitecustomize.py to customize the `site-packages` directory
cat << EOF > "$PACKIT_PACKAGE_PATH/lib/python$PACKIT_ARGS_MAJOR_MINOR_VERSION/site-packages/sitecustomize.py"
import os
import site

site.addsitedir(
    "${PYTHON_SITE_PACKAGES}"
)

# Set PIP_CONFIG_FILE so the pip.conf file can be found
os.environ["PIP_CONFIG_FILE"] = "${PYTHON_OPT}/pip.conf"
EOF

# Create pip configuration file
cat << EOF > "$PYTHON_OPT/pip.conf"
[global]
prefix = ${PYTHON_OPT}
EOF

$PACKIT_PACKAGE_PATH/bin/python -m ensurepip
