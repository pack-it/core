cd cmake-%PACKIT_PACKAGE_VERSION%

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"

if not exist "%VSWHERE%" (
    echo ERROR: Visual Studio Build Tools not found.
    echo Install one of the following:
    echo   https://aka.ms/vs/17/release/vs_BuildTools.exe
    echo   https://visualstudio.microsoft.com/
    exit /b 1
)

for /f "tokens=* usebackq" %%i in (`"%VSWHERE%" -latest -property installationPath`) do (
    set "VSPATH=%%i"
)

if not exist "%VSPATH%" (
    echo ERROR: Visual Studio cannot be loaded from %VSPATH%
    exit /b 1
)

set "VCVARSALL=%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat"

if not exist "%VCVARSALL%" (
    echo ERROR: vcvarsall.bat cannot be loaded from %VCVARSALL%
    exit /b 1
)

echo Found vcvarsall.bat at %VCVARSALL%

if "%PACKIT_TARGET%"=="x86_64-pc-windows-msvc" (
    set "ARCH=amd64"
) else if "%PACKIT_TARGET%"=="i686-pc-windows-msvc" (
    set "ARCH=x86"
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set "ARCH=arm64"
) else (
    echo ERROR: Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

call "%VCVARSALL%" %ARCH%

where cl >nul 2>nul
if ERRORLEVEL 1 (
    echo ERROR: cl.exe not found after loading MSVC environment.
    exit /b 1
)

bootstrap --prefix="%PACKIT_PACKAGE_PATH%" --no-system-libs --no-debugger
if ERRORLEVEL 1 (
    echo ERROR: bootstrap failed
    exit /b %ERRORLEVEL%
)

nmake
if ERRORLEVEL 1 (
    echo ERROR: build failed
    exit /b %ERRORLEVEL%
)

nmake install
if ERRORLEVEL 1 (
    echo ERROR: install failed
    exit /b %ERRORLEVEL%
)