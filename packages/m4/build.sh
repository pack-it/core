#!/bin/sh

./configure --disable-dependency-tracking --prefix=$PACKIT_PACKAGE_PATH

make

make install
