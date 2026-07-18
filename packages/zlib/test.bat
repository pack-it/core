REM Call vcvarsall.bat to initialize MSVC build environment
call "%PACKIT_VCVARSALL%" %PACKIT_VCVARSALL_ARCH% %PACKIT_OUTPUTS% >&3

set TEST_TEXT = "Hello World! Duck, Mouse, Bird, Dog, Horse, idk, that's all the animals I know. I hope it's enough for this test code :)"
echo "%TEST_TEXT%" > test.txt

REM Compile test.c
cl /I "%PACKIT_PACKAGE_PATH%\include" test.c /Fe:test.exe /link /LIBPATH:"%PACKIT_PACKAGE_PATH%\lib" zlib.lib %PACKIT_OUTPUTS% >&3 2>&3
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
