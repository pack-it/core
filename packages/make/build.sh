#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

sh build.sh

./make

# Requires Perl for the build tests

./make install
