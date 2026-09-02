#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# Make check needs runtest from DejaGNU

make install
