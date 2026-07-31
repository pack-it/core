cd xz-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest --verbose -C Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
