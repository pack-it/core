#!/bin/sh
cd xz-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install
