cd perl-%PACKIT_PACKAGE_VERSION%

cd win32

REM Read Visual Studio install path
for /f "tokens=* usebackq" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    set VSPATH=%%i
)
if not exist "%VSPATH%" (
    echo "Visual Studio cannot be loaded from %VSPATH%"
    exit /b 1
)

REM Check if vcvarsall.bat exists
set "VCVARSALL=%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat"
if not exist "%VCVARSALL%" (
    echo "vcvarsall.bat cannot be loaded from %VCVARSALL%"
    exit /b 1
)

REM Read MSVC version
for /f %%v in (%VSPATH%\VC\Auxiliary\Build\Microsoft.VCToolsVersion.default.txt) do (
    set "MSVCVERSION=%%v"
)
echo "Found MSVC version %MSVCVERSION%"

REM Convert MSVC version for make variable
set "MSVCMAJOR=%MSVCVERSION:~0,2%"
set "MSVCMINOR=%MSVCVERSION:~3,1%"
set "MSVCNAME=MSVC%MSVCMAJOR%%MSVCMINOR%"
echo "Found MSCV name %MSVCNAME%"

REM Retrieve architecture from target
IF "%PACKIT_TARGET%"=="x86_64-pc-windows-msvc" (
    set ARCH=x64
) ELSE IF "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set ARCH=arm64
) ELSE (
    echo "Target %PACKIT_TARGET% is not supported for this package"
    exit /b 1
)

REM Call vcvarsall.bat to set MSVC build environmnt
call %VCVARSALL% %ARCH%

REM Build Perl
nmake INST_TOP="%PACKIT_PACKAGE_PATH%" CCTYPE="%MSVCNAME%"
if ERRORLEVEL 1 (
    echo "Perl build failed"
    exit /b %ERRORLEVEL%
)

nmake test
if ERRORLEVEL 1 (
    echo "Perl tests failed"
    exit /b %ERRORLEVEL%
)

nmake install INST_TOP="%PACKIT_PACKAGE_PATH%"
if ERRORLEVEL 1 (
    echo "Perl install failed"
    exit /b %ERRORLEVEL%
)
