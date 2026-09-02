#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# Skipping test because tests are not include (located at: http://speleotrove.com/decimal/dectest.zip)

make install
