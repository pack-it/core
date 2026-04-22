#!/bin/sh
cd bzip2-$PACKIT_PACKAGE_VERSION

make 

make install PREFIX= "$PACKIT_PACKAGE_PATH"
