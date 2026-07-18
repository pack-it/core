cd mpdecimal-%PACKIT_PACKAGE_VERSION%

REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

set "MACHINE=x64"
if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    set "MACHINE=ansi64"
)

REM Go into C code libmpdec and compile it
cd libmpdec
copy /y Makefile.vc Makefile
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
nmake MACHINE=%MACHINE% DEBUG=0
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Move files to the correct directory
robocopy . "%PACKIT_PACKAGE_PATH%\include" mpdecimal.h
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\lib" libmpdec-4.0.1.lib libmpdec-4.0.1.dll libmpdec-4.0.1.dll.lib libmpdec-4.0.1.dll.exp
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec.lib" "%PACKIT_PACKAGE_PATH%\lib\libmpdec-4.0.1.lib"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec.dll" "%PACKIT_PACKAGE_PATH%\lib\libmpdec-4.0.1.dll"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec.dll.lib" "%PACKIT_PACKAGE_PATH%\lib\libmpdec-4.0.1.dll.lib"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec.dll.exp" "%PACKIT_PACKAGE_PATH%\lib\libmpdec-4.0.1.dll.exp"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Go into C++ code libmpdec and compile it
cd ..\libmpdec++
copy /y Makefile.vc Makefile
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
nmake DEBUG=0
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM Move files to the correct directory
robocopy . "%PACKIT_PACKAGE_PATH%\include" decimal.hh
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\lib" libmpdec++-4.0.1.lib libmpdec++-4.0.1.dll libmpdec++-4.0.1.dll.lib libmpdec++-4.0.1.dll.exp
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec++.lib" "%PACKIT_PACKAGE_PATH%\lib\libmpdec++-4.0.1.lib"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec++.dll" "%PACKIT_PACKAGE_PATH%\lib\libmpdec++-4.0.1.dll"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec++.dll.lib" "%PACKIT_PACKAGE_PATH%\lib\libmpdec++-4.0.1.dll.lib"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
mklink "%PACKIT_PACKAGE_PATH%\lib\libmpdec++.dll.exp" "%PACKIT_PACKAGE_PATH%\lib\libmpdec++-4.0.1.dll.exp"
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
