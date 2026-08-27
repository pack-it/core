#!/bin/sh

./configure --disable-dependency-tracking --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

make install
