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

set TEST_TEXT = "Hello World! Duck, Mouse, Bird, Dog, Horse, idk, that's all the animals I know. I hope it's enough for this test code :)"
echo "%TEST_TEXT%" > test.txt

REM Compile test.c
cl /I "%PACKIT_PACKAGE_PATH%\include" test.c /Fe:test.exe /link /LIBPATH:"%PACKIT_PACKAGE_PATH%\lib" zlib.lib
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Compress the test.txt file
.\test.exe < test.txt > compressed
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Decompress the compressed file
.\test.exe -d < compressed > decompressed.txt
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1
