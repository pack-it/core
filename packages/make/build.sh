#!/bin/sh
cd make-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH

sh build.sh

./make 

./make install
