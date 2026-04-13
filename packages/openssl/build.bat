cd openssl-%PACKIT_PACKAGE_VERSION%

REM Read Visual Studio install path
for /f "tokens=* usebackq" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    set VSPATH=%%i
)
if not exist "%VSPATH%" (
    echo Visual Studio cannot be loaded from %VSPATH%
    exit /b 1
)

REM Check if vcvarsall.bat exists
set "VCVARSALL=%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat"
if not exist "%VCVARSALL%" (
    echo vcvarsall.bat cannot be loaded from %VCVARSALL%
    exit /b 1
)
echo Found vcvarsall.bat at %VCVARSALL%

REM Retrieve architecture from target
if "%PACKIT_TARGET%"=="x86_64-pc-windows-msvc" (
    set ARCH=x64
    set CONFIGURETARGET=VC-WIN64A
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set ARCH=arm64
    set CONFIGURETARGET=VC-WIN64-ARM
) else (
    echo Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

REM Call vcvarsall.bat to set MSVC build environment
call "%VCVARSALL%" %ARCH%

REM TODO: enable asm when nasm is available as package
perl configure %CONFIGURETARGET% no-asm "--prefix=%PACKIT_PACKAGE_PATH%" "--openssldir=%PACKIT_PREFIX_PATH%/etc/openssl@%PACKIT_PACKAGE_VERSION%"

nmake
if ERRORLEVEL 1 (
    echo OpenSSL build failed
    exit /b %ERRORLEVEL%
)

nmake test
if ERRORLEVEL 1 (
    echo OpenSSL tests failed
    exit /b %ERRORLEVEL%
)

nmake install
if ERRORLEVEL 1 (
    echo OpenSSL install failed
    exit /b %ERRORLEVEL%
)
