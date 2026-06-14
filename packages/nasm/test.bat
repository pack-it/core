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

REM Hello example from https://cs.lmu.edu/~ray/notes/nasmtutorial/
(
    echo         global  main
    echo         extern  puts
    echo         section .text
    echo main:
    echo         sub     rsp, 28h
    echo         mov     rcx, message
    echo         call    puts
    echo         add     rsp, 28h
    echo         ret
    echo message:
    echo         db      'Hello', 0
) > test.asm

"%PACKIT_PACKAGE_PATH%\bin\nasm.exe" -f win32 test.asm
link /subsystem:console /entry:main /out:test.exe test.obj

for /f "delims=" %%A in ("test.exe") do set "output=%%A"
if ERRORLEVEL 1 (
    echo Test failed: test assembly executable exited with code %ERRORLEVEL%
    exit /b 1
)

if "%output%" == "Hello" (
    exit /b 0
)

exit /b 1
