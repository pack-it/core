REM Test relies on GCC, so first check if gcc is installed
where gcc
if ERRORLEVEL 1 (
    echo GCC not installed, skipping test
    exit /b 0
)

set TEST_TEXT = "Hello World! Duck, Mouse, Bird, Dog, Horse, idk, that's all the animals I know. I hope it's enough for this test code :)"
echo "%TEST_TEXT%" > test.txt

REM Compile test.c
gcc -L "%PACKIT_PACKAGE_PATH%/lib" -I "%PACKIT_PACKAGE_PATH%/include" test.c -o test -lz

REM Compress the test.txt file
test.exe < test.txt > compressed

REM Decompress the compressed file
test.exe -d < compressed > decompressed.txt

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1