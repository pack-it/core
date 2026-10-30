#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH \
    --docdir=$PACKIT_PACKAGE_PATH/share/doc/libiconv \
    --enable-extra-encodings

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install
