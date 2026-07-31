cd xz-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build-static -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-static --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-static --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake -S . -B build-shared -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build-shared --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build-shared --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
