cd cmake-%PACKIT_PACKAGE_VERSION%

REM Try to find Visual Studio vswhere.exe default installed read this in vcpackage install script 
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"

if not exist "%VSWHERE%" (
    echo.
    echo ERROR: Visual Studio Build Tools not found.
    echo.
    echo Please install one of the following:
    echo   - Visual Studio Build Tools:
    echo     https://aka.ms/vs/17/release/vs_BuildTools.exe
    echo   - Full Visual Studio:
    echo     https://visualstudio.microsoft.com/
    echo.
    echo After installation, re-run this build.
    exit /b 1
)

REM Get latest VS installation path
for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -property installationPath`) do (
    set "VSPATH=%%i"
)

if not exist "%VSPATH%" (
    echo ERROR: No valid Visual Studio installation found.
    exit /b 1
)

REM Load MSVC environment
set "VCVARS=%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat"

if not exist "%VCVARS%" (
    echo ERROR: vcvarsall.bat not found.
    echo Make sure C++ build tools are installed.
    exit /b 1
)

call "%VCVARS%" amd64

REM Check if compiler exists
where cl >nul 2>nul
if ERRORLEVEL 1 (
    echo ERROR: MSVC compiler (cl.exe) not found after environment setup.
    exit /b 1
)

echo MSVC environment loaded.

REM Build CMake using bootstrap
bootstrap ^
  --prefix="%PACKIT_PACKAGE_PATH%" ^
  --no-system-libs ^
  --no-debugger

if ERRORLEVEL 1 exit /b 1

nmake
if ERRORLEVEL 1 exit /b 1

nmake install
if ERRORLEVEL 1 exit /b 1

echo.
echo CMake build completed successfully.
exit /b 0