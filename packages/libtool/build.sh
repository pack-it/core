#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules --enable-ltdl-install

make -j $PACKIT_BUILD_JOBS_COUNT

make install
