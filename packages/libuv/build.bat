cd libuv-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build -DCMAKE_INSTALL_PREFIX=%PACKIT_PACKAGE_PATH%

cmake --build build

cmake --install build


