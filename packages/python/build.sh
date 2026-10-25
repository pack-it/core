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

# Define the site-packages location
PYTHON_ETC="$PACKIT_PREFIX_PATH/etc/python"
PYTHON_SITE_PACKAGES="$PYTHON_ETC/lib/python$PACKIT_ARGS_MAJOR_MINOR_VERSION/site-packages"
mkdir -p $PYTHON_ETC

# Create sitecustomize.py to customize the `site-packages` directory
cat << EOF > "$PACKIT_PACKAGE_PATH/lib/python$PACKIT_ARGS_MAJOR_MINOR_VERSION/site-packages/sitecustomize.py"
import os
import site

site.addsitedir(
    "${PYTHON_SITE_PACKAGES}"
)

# Set PIP_CONFIG_FILE so the pip.conf file can be found
os.environ["PIP_CONFIG_FILE"] = "${PYTHON_ETC}/pip.conf"
EOF

# Create pip configuration file
cat << EOF > "$PYTHON_ETC/pip.conf"
[global]
prefix = ${PYTHON_ETC}
EOF

$PACKIT_PACKAGE_PATH/bin/python -m ensurepip
