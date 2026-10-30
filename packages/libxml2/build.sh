#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules \
    --with-legacy \
    --with-history \
    --with-readline \
    --with-zlib

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install

# Change working directory to patch xml2-config
cd $PACKIT_PACKAGE_PATH

# Replace prefix inside xml2-config script
sed -i '' "s|$PACKIT_PACKAGE_PATH|$PACKIT_PREFIX_PATH/active/libxml2|g" bin/xml2-config
