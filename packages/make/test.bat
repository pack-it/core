set "test_output=Let's make make work"

(
    echo all:
    echo 	@echo %test_output%
) > Makefile

for /f "usebackq delims=" %%A in (`"%PACKIT_PACKAGE_PATH%\bin\make.exe"`) do set "output=%%A"
if ERRORLEVEL 1 (
    echo Test failed: make command exited with code %ERRORLEVEL%
    exit /b 1
)

if "%output%" == "%test_output%" (
    exit /b 0
)

exit /b 1
