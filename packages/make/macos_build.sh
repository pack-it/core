#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --program-prefix=g

sh build.sh

./make

./make install

[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && ./make check

# Create gnubin to allow adding make without g prefix to path
mkdir $PACKIT_PACKAGE_PATH/gnubin
cd $PACKIT_PACKAGE_PATH/gnubin

ln -s ../bin/gmake make
