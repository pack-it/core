#!/bin/sh
cd libgit2-$PACKIT_PACKAGE_VERSION

flags=""
if [ "$PACKIT_OS" = "mac" ]; then
    lib_extension="dylib"

    # The DCMAKE_INSTALL_RPATH is needed because llhttp has an install name containing @rpath
    flags="-DCMAKE_INSTALL_RPATH=\"$PACKIT_PACKAGE_DEPENDENCIES_PATH/llhttp/lib\""
elif [ "$PACKIT_OS" = "linux" ]; then
    lib_extension="so"

    flags="-DREGEX_BACKEND=pcre2"
    flags="$flags -DPCRE2_LIBRARY=$PACKIT_PACKAGE_DEPENDENCIES_PATH/pcre2/lib/libpcre2-8.so"
    flags="$flags -DPCRE2_INCLUDE_DIR=$PACKIT_PACKAGE_DEPENDENCIES_PATH/pcre2/include"
fi

# Put shared flags in the flags
flags="$flags -DBUILD_TESTS=ON"
flags="$flags -DUSE_HTTP_PARSER=llhttp"
flags="$flags -DUSE_SSH=ON"
flags="$flags -DUSE_BUNDLED_ZLIB=OFF"
flags="$flags -DLLHTTP_INCLUDE_DIR=$PACKIT_PACKAGE_DEPENDENCIES_PATH/llhttp/include"
flags="$flags -DLLHTTP_LIBRARY=$PACKIT_PACKAGE_DEPENDENCIES_PATH/llhttp/lib/libllhttp.$lib_extension"
flags="$flags -DLIBSSH2_INCLUDE_DIR=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libssh2/include"
flags="$flags -DLIBSSH2_LIBRARY=$PACKIT_PACKAGE_DEPENDENCIES_PATH/libssh2/lib/libssh2.$lib_extension"

# Build static library
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF $flags

cmake --build build-static --config Release

# Build tests depend on python, so only execute on macos where python is installed by default
if [ "$PACKIT_OS" = "mac" ]; then
    ctest --verbose -C Release --test-dir build-static -E "online|proxy|auth_clone"
fi

cmake --install build-static --config Release

# Build shared libraries
cmake -S . -B build-shared -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON $flags

cmake --build build-shared --config Release

# Build tests depend on python, so only execute on macos where python is installed by default
if [ "$PACKIT_OS" = "mac" ]; then
    ctest --verbose -C Release --test-dir build-shared -E "online|proxy|auth_clone"
fi

cmake --install build-shared --config Release
