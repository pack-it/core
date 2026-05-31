cd zlib-ng-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build "-DCMAKE_INSTALL_PREFIX=%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF

cmake --build build

ctest --verbose -C Release

cmake --install build
