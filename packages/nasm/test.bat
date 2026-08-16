REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

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

"%PACKIT_PACKAGE_PATH%\bin\nasm.exe" -f win64 test.asm
link /subsystem:console /out:test.exe test.obj msvcrt.lib %PACKIT_OUTPUTS% >&3

REM Skip the execution on ARM based targets, because NASM is not build for it
if "%PACKIT_TARGET%"=="aarch64-pc-windows-msvc" (
    exit /b 0
)

for /f "usebackq delims=" %%A in (`test.exe`) do set "output=%%A"
if ERRORLEVEL 1 (
    echo Test failed: test assembly executable exited with code %ERRORLEVEL%
    exit /b 1
)

if not "%output%" == "Hello" (
    echo Test failed: test output '%output%' does not match the expected output
    exit /b 1
)
