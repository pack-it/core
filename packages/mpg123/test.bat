"%PACKIT_PACKAGE_PATH%\bin\mpg123" -t .\test.mp3
if ERRORLEVEL 1 exit /b %ERRORLEVEL%
