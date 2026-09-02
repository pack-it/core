cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

ctest -C Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
