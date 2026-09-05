REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

if "%PACKIT_TARGET%"=="x86_64-pc-windows-msvc" (
    perl configure VC-WIN64A "--prefix=%PACKIT_PACKAGE_PATH%" "--openssldir=%PACKIT_PREFIX_PATH%/etc/openssl@%PACKIT_PACKAGE_VERSION%"
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    perl configure VC-WIN64-ARM no-asm "--prefix=%PACKIT_PACKAGE_PATH%" "--openssldir=%PACKIT_PREFIX_PATH%/etc/openssl@%PACKIT_PACKAGE_VERSION%"
) else (
    echo Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

nmake
if ERRORLEVEL 1 (
    echo OpenSSL build failed
    exit /b %ERRORLEVEL%
)

REM Test group 70 does not reliably work on Windows
if "%PACKIT_EXECUTE_BUILD_TEST%"=="1" nmake test TESTS="-70"
if ERRORLEVEL 1 (
    echo OpenSSL tests failed
    exit /b %ERRORLEVEL%
)

nmake install
if ERRORLEVEL 1 (
    echo OpenSSL install failed
    exit /b %ERRORLEVEL%
)
