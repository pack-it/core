#!/bin/sh
cd bzip2-$PACKIT_PACKAGE_VERSION

make 

make install PREFIX="$PACKIT_PACKAGE_PATH"

mkdir $PACKIT_PACKAGE_PATH/share
mv $PACKIT_PACKAGE_PATH/man $PACKIT_PACKAGE_PATH/share/man

if [ "$PACKIT_OS" = "linux" ]; then
    make -f Makefile-libbz2_so clean
    make -f Makefile-libbz2_so

    mv libbz2.so.$PACKIT_PACKAGE_VERSION $PACKIT_PACKAGE_PATH/lib/libbz2.so.$PACKIT_PACKAGE_VERSION
    mv libbz2.so.$PACKIT_ARGS_MAJOR_MINOR_VERSION $PACKIT_PACKAGE_PATH/lib/libbz2.so.$PACKIT_ARGS_MAJOR_MINOR_VERSION

    ln -s libbz2.so.$PACKIT_PACKAGE_VERSION $PACKIT_PACKAGE_PATH/lib/libbz2.so
    ln -s libbz2.so.$PACKIT_PACKAGE_VERSION $PACKIT_PACKAGE_PATH/lib/libbz2.so.$PACKIT_ARGS_MAJOR_VERSION

    # Create pkgconfig file based on 1.1.x repository
    # https://gitlab.com/bzip2/bzip2/-/blob/master/bzip2.pc.in
    mkdir $PACKIT_PACKAGE_PATH/lib/pkgconfig
    cat > $PACKIT_PACKAGE_PATH/lib/pkgconfig/bzip.pc << EOF
prefix=$PACKIT_PACKAGE_PATH
exec_prefix=\${prefix}
bindir=\${exec_prefix}/bin
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: bzip2
Description: Lossless, block-sorting data compression
Version: $PACKIT_PACKAGE_VERSION
Libs: -L\${libdir} -lbz2
Cflags: -I\${includedir}
EOF
fi
