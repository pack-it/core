#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# TODO: Needs a separate test test from http://speleotrove.com/decimal/dectest.zip
# make test

make install
