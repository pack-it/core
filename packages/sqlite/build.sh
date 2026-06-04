#!/bin/sh
cd sqlite-$PACKIT_PACKAGE_VERSION

export CPPFLAGS="$CPPFLAGS \
-DSQLITE_ENABLE_API_ARMOR=1 \
-DSQLITE_ENABLE_COLUMN_METADATA=1 \
-DSQLITE_ENABLE_DBSTAT_VTAB=1 \
-DSQLITE_ENABLE_FTS3_PARENTHESIS=1 \
-DSQLITE_SECURE_DELETE=1 \
-DSQLITE_ENABLE_STMTVTAB=1 \
-DSQLITE_ENABLE_STAT4=1 \
-DSQLITE_ENABLE_UNLOCK_NOTIFY=1 \
-DSQLITE_MAX_VARIABLE_NUMBER=250000 \
-DSQLITE_USE_URI=1 \
-DSQLITE_ENABLE_MATH_FUNCTIONS=1"

extra_flags=""
if [ "$PACKIT_OS" = "linux" ]; then
    extra_flags="--soname=legacy"
fi

./configure --prefix="$PACKIT_PACKAGE_PATH" \
    --disable-static \
    --with-readline-cflags="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/readline/include" \
    --with-readline-ldflags="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/readline/lib -lreadline" \
    --fts3 \
    --fts4 \
    --fts5 \
    --geopoly \
    --rtree \
    --session \
    $extra_flags

make

make install
