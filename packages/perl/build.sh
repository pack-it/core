#!/bin/sh
cd perl-$PACKIT_PACKAGE_VERSION

active_dir="$PACKIT_PREFIX_PATH/active/perl"

./Configure -des \
    -Dinstallprefix=$PACKIT_PACKAGE_PATH \
    -Dprefix=$active_dir \
    -Dprivlib=$PACKIT_PACKAGE_PATH/lib/perl5/ \
    -Dsitelib=$PACKIT_PREFIX_PATH/lib/perl5/site_perl/$PACKIT_ARGS_LIB_VERSION \
    -Dvendorlib=$PACKIT_PREFIX_PATH/lib/perl5/vendor_perl/$PACKIT_ARGS_LIB_VERSION \
    -Dvendorprefix=$PACKIT_PREFIX_PATH \
    -Dperlpath=$active_dir/bin/perl \
    -Dstartperl="#!$active_dir/bin/perl" \
    -Dman1dir=$PACKIT_PACKAGE_PATH/share/man/man1 \
    -Dman3dir=$PACKIT_PACKAGE_PATH/share/man/man3 \
    -Duseshrplib \
    -Duselargefiles \
    -Dusethreads

make

make test

make install
