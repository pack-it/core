REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

REM See: SIMDJSON_USING_WINDOWS_DYNAMIC_LIBRARY in https://github.com/simdjson/simdjson/blob/master/include/simdjson/common_defs.h
cl /EHs /DSIMDJSON_USING_WINDOWS_DYNAMIC_LIBRARY=1 /I "%PACKIT_PACKAGE_PATH%\include" test.cpp /Fe:test.exe /link /LIBPATH:"%PACKIT_PACKAGE_PATH%\lib" simdjson.lib %PACKIT_OUTPUTS% >&3 2>&3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

.\test.exe
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
