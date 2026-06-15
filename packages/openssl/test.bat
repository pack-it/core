echo I hashed the previous version of this script, unfortunately the hash was my only backup. Whoops! > test.txt

REM This hash does not match the hash on Unix, due to line ending differences
set "expected_output=SHA2-256(stdin)= a6a6ac959ebea1f5ec010438e2ccec6fbc73f1cc53797a02ae6cbf3cd9477e9a"

for /f "usebackq delims=" %%A in (`"%PACKIT_PACKAGE_PATH%\bin\openssl.exe" sha256 -hex ^< test.txt`) do set "output=%%A"
if ERRORLEVEL 1 (
    echo Test failed: openssl command exited with code %ERRORLEVEL%
    exit /b 1
)

if not "%output%" == "%expected_output%" (
    echo Test failed: sha256 hashing test did not output the expected hash
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\openssl.exe" verify test.pem >output.txt 2>&1
findstr /C:"verification failed" output.txt >nul
if errorlevel 1 (
    echo Test failed: verifying an invalid certificate did not result in a failed verification
    exit /b 1
)
