#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make check

make install
