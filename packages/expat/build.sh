#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --mandir="$PACKIT_PACKAGE_PATH/share/man"

make -j $PACKIT_BUILD_JOBS_COUNT

cd build && make test -j $PACKIT_BUILD_JOBS_COUNT

make install
