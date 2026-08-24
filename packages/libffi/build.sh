#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

# Make check needs runtest from DejaGNU

make install
