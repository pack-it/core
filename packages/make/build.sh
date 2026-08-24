#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

sh build.sh

./make -j $PACKIT_BUILD_JOBS_COUNT

# Requires Perl for the build tests

./make install
