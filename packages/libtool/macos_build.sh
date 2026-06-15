#!/bin/sh
cd libtool-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules --enable-ltdl-install --program-prefix=g

make

make install

# Create gnubin to allow adding libtool without g prefix to path
mkdir $PACKIT_PACKAGE_PATH/gnubin
cd $PACKIT_PACKAGE_PATH/gnubin

ln -s ../bin/glibtool libtool
ln -s ../bin/glibtoolize libtoolize
