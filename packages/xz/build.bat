cd xz-%PACKIT_PACKAGE_VERSION%

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Copy liblzma.dll to ensure tests work
copy Release\liblzma.dll liblzma.dll

ctest --verbose -C Release --test-dir build
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
