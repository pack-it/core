#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules --enable-ltdl-install --program-prefix=g

make

# Skip test 146, because of wrongly set paths in the test which causes linking problems
# `INNER_TESTSUITEFLAGS="-145 147-171 173-"` stops test 146 being run again and prevents infinite recursion
[ "${PACKIT_EXECUTE_BUILD_TEST:-}" = "1" ] && make check TESTSUITEFLAGS="-145 147-" INNER_TESTSUITEFLAGS="-145 147-171 173-"

make install

# Create gnubin to allow adding libtool without g prefix to path
mkdir $PACKIT_PACKAGE_PATH/gnubin
cd $PACKIT_PACKAGE_PATH/gnubin

ln -s ../bin/glibtool libtool
ln -s ../bin/glibtoolize libtoolize
