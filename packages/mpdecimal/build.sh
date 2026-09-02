#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# Skipping tests because tests are not included (located at: http://speleotrove.com/decimal/dectest.zip)

make install
