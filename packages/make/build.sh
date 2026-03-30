#!/bin/sh
cd make-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --program-prefix=g

sh build.sh

./make 

./make install
