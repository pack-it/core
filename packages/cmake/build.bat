cd cmake-%PACKIT_PACKAGE_VERSION%

REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

REM Bootstrap cmake
powershell -File .\bootstrap.ps1 -prefix "%PACKIT_PACKAGE_PATH%" -no-system-libs -no-debugger
if ERRORLEVEL 1 (
    echo CMake bootstrap failed
    exit /b %ERRORLEVEL%
)

REM Build cmake
nmake
if ERRORLEVEL 1 (
    echo CMake build failed
    exit /b %ERRORLEVEL%
)

nmake install
if ERRORLEVEL 1 (
    echo CMake install failed
    exit /b %ERRORLEVEL%
)
