#!/bin/sh
cd libgit2-$PACKIT_PACKAGE_VERSION

extra_flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    # The DCMAKE_INSTALL_RPATH is needed because llhttp has an install name containing @rpath
    extra_flags="-DCMAKE_INSTALL_RPATH=\"$PACKIT_PACKAGE_DEPENDENCIES_PATH/llhttp/lib\""
else
    extra_flags="-DREGEX_BACKEND=pcre2"
    extra_flags="$extra_flags -DPCRE2_LIBRARY=$PACKIT_PACKAGE_DEPENDENCIES_PATH/pcre2/lib/libpcre2-8.so"
fi

# Build static library
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTS=ON \
    -DBUILD_SHARED_LIBS=OFF \
    -DUSE_HTTP_PARSER=llhttp \
    -DUSE_SSH=ON \
    -DUSE_BUNDLED_ZLIB=OFF \
    $extra_flags

cmake --build build-static --config Release

# Build tests depend on python, so only execute on macos where python is installed by default
if [ "$PACKIT_OS" = "mac" ]; then
    ctest --verbose -C Release --test-dir build-static -E "online|proxy|auth_clone"
fi

cmake --install build-static --config Release

# Build shared libraries
cmake -S . -B build-shared -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTS=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DUSE_HTTP_PARSER=llhttp \
    -DUSE_SSH=ON \
    -DUSE_BUNDLED_ZLIB=OFF \
    $extra_flags

cmake --build build-shared --config Release

# Build tests depend on python, so only execute on macos where python is installed by default
if [ "$PACKIT_OS" = "mac" ]; then
    ctest --verbose -C Release --test-dir build-shared -E "online|proxy|auth_clone"
fi

cmake --install build-shared --config Release
