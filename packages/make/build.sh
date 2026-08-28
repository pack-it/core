#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

sh build.sh

./make

# Requires PERL for the build tests

./make install
