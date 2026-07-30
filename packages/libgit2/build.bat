cd libgit2-%PACKIT_PACKAGE_VERSION%

REM Build static library
cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DUSE_HTTP_PARSER=llhttp -DUSE_SSH=ON -DUSE_BUNDLED_ZLIB=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-static --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-static --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Build shared libraries
cmake -S . -B build-shared -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DUSE_HTTP_PARSER=llhttp -DUSE_SSH=ON -DUSE_BUNDLED_ZLIB=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-shared --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-shared --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
