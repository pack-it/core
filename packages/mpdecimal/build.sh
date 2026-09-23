#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make -j $PACKIT_BUILD_JOBS_COUNT

# Skipping tests because tests are not included (located at: http://speleotrove.com/decimal/dectest.zip)

make install
