cd libgit2-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PACKIT_PACKAGE_PATH" -DUSE_HTTP_PARSER=llhttp -DUSE_SSH=ON -DUSE_BUNDLED_ZLIB=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
