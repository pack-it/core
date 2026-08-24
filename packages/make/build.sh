#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

sh build.sh

./make

# TODO: Requires PERL
./run_make_tests

./make install
