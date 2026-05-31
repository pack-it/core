cd zlib-ng-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DBUILD_TESTING=OFF -DZLIB_COMPAT=ON

cmake --build build --config Release

ctest --verbose -C Release

cmake --install build
