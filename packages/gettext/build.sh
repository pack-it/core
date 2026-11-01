#!/bin/sh

# Build gettext library
cd gettext-runtime

extra_flags=""
if [ "$PACKIT_OS" = "linux" ]; then
    extra_flags="--with-libxml2-prefix=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libxml2"
fi

# Only give libiconv prefix to configure if it is a dependency
if [ -d "$PACKIT_PACKAGE_DEPENDENCIES_PATH/libiconv" ]; then
    extra_flags="$extra_flags --with-libiconv-prefix=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libiconv"
fi

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules \
    --disable-java \
    --with-libunistring-prefix=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libunistring \
    --without-git \
    --localedir=$PACKIT_PREFIX_PATH/share/locale \
    $extra_flags

make -j $PACKIT_BUILD_JOBS_COUNT

# gettext-runtime does not contain any tests

make install

# Build libtextstyle
cd ../libtextstyle

./configure --prefix=$PACKIT_PACKAGE_PATH --disable-silent-rules $extra_flags

make -j $PACKIT_BUILD_JOBS_COUNT

[ "${PACKIT_EXECUTE_BUILD_TEST}" = "1" ] && make check -j $PACKIT_BUILD_JOBS_COUNT

make install

# Remove unwanted csharp and java docs
rm -r "$PACKIT_PACKAGE_PATH/share/doc/gettext/csharpdoc"
rm -r "$PACKIT_PACKAGE_PATH/share/doc/gettext/javadoc2"
