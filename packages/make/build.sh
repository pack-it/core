#!/bin/sh
cd make-$PACKIT_PACKAGE_VERSION

if [[ $PACKIT_TARGET =~ "linux" ]]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH
fi

if [[ $PACKIT_TARGET =~ "apple" ]]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH --program-prefix=g
fi

sh build.sh

./make 

./make install
