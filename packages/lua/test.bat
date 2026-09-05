```bat
@echo off

set "TEST_TEXT=shoot for the stars, aim for the moon"

REM Test Lua interpreter
for /f "delims=" %%i in ('"%PACKIT_PACKAGE_PATH%\bin\lua.exe" -e "print(""shoot for the stars, aim for the moon"")"') do (
    set "RESULT=%%i"
)

if not "%RESULT%"=="%TEST_TEXT%" (
    echo Lua interpreter test failed
    exit /b 1
)

REM Create a Lua source file
echo print("shoot for the stars, aim for the moon") > test.lua

REM Test running a Lua source file
set "RESULT="
for /f "delims=" %%i in ('"%PACKIT_PACKAGE_PATH%\bin\lua.exe" test.lua') do (
    set "RESULT=%%i"
)

if not "%RESULT%"=="%TEST_TEXT%" (
    echo Lua script execution test failed
    del /q test.lua
    exit /b 1
)

REM Test Lua compiler
"%PACKIT_PACKAGE_PATH%\bin\luac.exe" -o test.luac test.lua

if ERRORLEVEL 1 (
    echo Lua compiler test failed
    del /q test.lua
    exit /b 1
)

REM Test running compiled Lua bytecode
set "RESULT="
for /f "delims=" %%i in ('"%PACKIT_PACKAGE_PATH%\bin\lua.exe" test.luac') do (
    set "RESULT=%%i"
)

if not "%RESULT%"=="%TEST_TEXT%" (
    echo Test failed: Lua bytecode execution test failed
    del /q test.lua
    del /q test.luac
    exit /b 1
)

del /q test.lua
del /q test.luac

exit /b 0
```
