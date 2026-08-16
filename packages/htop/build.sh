#!/bin/sh

./autogen.sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install
