set TEST_TEXT = "CMake is finally added as package, so we can add xz!"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
xz -c test.txt > compressed.xz
xz -dc compressed.xz > decompressed.txt

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1
