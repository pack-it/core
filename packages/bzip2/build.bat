cd bzip2-%PACKIT_PACKAGE_VERSION%

REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

nmake -f makefile.msc 
if ERRORLEVEL 1 (
    echo Bzip2 build failed
    exit /b %ERRORLEVEL%
)

robocopy . "%PACKIT_PACKAGE_PATH%\bin" bzip2.exe
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\bin" bzip2recover.exe
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\lib" libbz2.lib
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%
robocopy . "%PACKIT_PACKAGE_PATH%\include" bzlib.h
if %ERRORLEVEL% GEQ 8 exit /b %ERRORLEVEL%

exit /b 0
