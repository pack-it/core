REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH%

msbuild source\allinone\allinone.sln /m /p:Configuration=Release /p:Platform=x64 /p:SkipUWP=true
if ERRORLEVEL 1 exit /b %ERRORLEVEL%

REM source\allinone\icucheck.bat x64 Release
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
