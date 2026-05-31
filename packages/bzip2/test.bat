set TEST_TEXT = "Long live Packit!"
echo "%TEST_TEXT%" > test.txt

REM Compress and decompress to see if information stays the same
"%PACKIT_PACKAGE_PATH%\bin\bzip2" -c test.txt > compressed.bz2
if ERRORLEVEL 1 (
    echo Compression failed
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\bzip2" -d compressed.bz2 > decompressed.txt
if ERRORLEVEL 1 (
    echo Decompression failed
    exit /b 1
)

set /p RESULT = < decompressed.txt

if "%RESULT%" == "%TEST_TEXT%" (
    exit /b 0
)

exit /b 1
