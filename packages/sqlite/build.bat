cd sqlite-autoconf-%PACKIT_ARGS_ARCHIVE_VERSION%

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
) else if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set ARCH=arm64
) else (
    echo Target %PACKIT_TARGET% is not supported for this package
    exit /b 1
)

REM Call vcvarsall.bat to set MSVC build environment
call "%VCVARSALL%" %ARCH%

set "OPTIONS=-DSQLITE_ENABLE_API_ARMOR=1 ^
-DSQLITE_ENABLE_COLUMN_METADATA=1 ^
-DSQLITE_ENABLE_DBSTAT_VTAB=1 ^
-DSQLITE_ENABLE_FTS3_PARENTHESIS=1 ^
-DSQLITE_SECURE_DELETE=1 ^
-DSQLITE_ENABLE_STMTVTAB=1 ^
-DSQLITE_ENABLE_STAT4=1 ^
-DSQLITE_ENABLE_UNLOCK_NOTIFY=1 ^
-DSQLITE_MAX_VARIABLE_NUMBER=250000 ^
-DSQLITE_USE_URI=1 ^
-DSQLITE_ENABLE_MATH_FUNCTIONS=1 ^
-DSQLITE_ENABLE_FTS3=1 ^
-DSQLITE_ENABLE_FTS4=1 ^
-DSQLITE_ENABLE_FTS5=1
-DSQLITE_ENABLE_GEOPOLY=1 ^
-DSQLITE_ENABLE_RTREE=1 ^
-DSQLITE_ENABLE_SESSION=1"

nmake -f Makefile.msc USE_ZLIB=1 BUILD_ZLIB=0 ZLIBDIR="%PACKIT_PACKAGE_DEPENDENCIES_PATH%\zlib-ng-compat" OPTIONS="%OPTIONS%"
if ERRORLEVEL 1 (
    echo Building sqlite failed
    exit /b 1
)

mkdir "%PACKIT_PACKAGE_PATH%\bin\"
mkdir "%PACKIT_PACKAGE_PATH%\lib\"
mkdir "%PACKIT_PACKAGE_PATH%\include\"

move "sqlite3.exe" "%PACKIT_PACKAGE_PATH%\bin\"
move "sqlite3.dll" "%PACKIT_PACKAGE_PATH%\bin\"
move "sqlite3.lib" "%PACKIT_PACKAGE_PATH%\lib\"
move "sqlite3.h" "%PACKIT_PACKAGE_PATH%\include\"
