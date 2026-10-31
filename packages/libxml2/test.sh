#!/bin/sh

gcc test.c -o test $($PACKIT_PACKAGE_PATH/bin/xml2-config --cflags --libs) -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib"

./test
