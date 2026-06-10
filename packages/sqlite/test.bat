set "db_path=test.db"
(
    echo 4|Bob|25
    echo 2|Bob|10
    echo 1|Eve|17
    echo 3|Linus|20
) > expected_output.txt

"%PACKIT_PACKAGE_PATH%\bin\sqlite3.exe" %db_path% < test.sql > output.txt
if ERRORLEVEL 1 (
    echo Test failed: sqlite3 command exited with code %ERRORLEVEL%
    exit /b 1
)

if not exist "%db_path%" (
    echo Test failed: test database file is not created
    exit /b 1
)

fc output.txt expected_output.txt > nul
if ERRORLEVEL 1 exit /b 1

exit /b 0
