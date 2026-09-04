@echo off

cd neovim-%PACKIT_PACKAGE_VERSION%

REM Read Visual Studio install path
for /f "tokens=* usebackq" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    set VSPATH=%%i
)

if not exist "%VSPATH%" (
    echo Visual Studio cannot be loaded from %VSPATH%
    exit /b 1
)

set "VCVARSALL=%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat"
if not exist "%VCVARSALL%" (
    echo vcvarsall.bat cannot be loaded from %VCVARSALL%
    exit /b 1
)

if "%PACKIT_TARGET%"=="x86_64-pc-windows-msvc" (
    set ARCH=x64
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set ARCH=arm64
) else (
    echo Unsupported target %PACKIT_TARGET%
    exit /b 1
)

call "%VCVARSALL%" %ARCH%

cmake -B build ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%PACKIT_PACKAGE_PATH%"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --build build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

cmake --install build --config Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%