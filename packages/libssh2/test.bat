REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

cl /I "%PACKIT_PACKAGE_PATH%\include" test.c /Fe:test.exe /link /LIBPATH:"%PACKIT_PACKAGE_PATH%\lib" libssh2.lib %PACKIT_OUTPUTS% >&3 2>&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

.\test.exe
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
