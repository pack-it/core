cmake -S . -B build -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%" -DCMAKE_BUILD_TYPE=Release -DBUILD_TEST=ON
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release --parallel %PACKIT_BUILD_JOBS_COUNT%
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM We use cmake instead of `make_win.bat`, because cmake supports specifying a prefix. The cmake tests don't appear to exist/work.

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
