set "test_text=Me: 'Did I just see a camel walk by?', Larry: 'Oh yeah, that's my pet, he is called Perl'"

(
    echo print "%test_text%\n"
) > test.pl
for /f "usebackq delims=" %%A in (`"%PACKIT_PACKAGE_PATH%\bin\perl.exe" test.pl`) do set "output=%%A"
if ERRORLEVEL 1 (
    echo Test failed: perl command exited with code %ERRORLEVEL%
    exit /b 1
)

if not "%output%" == "%test_text%" (
    echo Test failed: perl print test did not print the expected text
    exit /b 1
)

"%PACKIT_PACKAGE_PATH%\bin\perl.exe" -e "exit(1) unless (2 + 2 == 4)"
if ERRORLEVEL 1 (
    echo Test failed: perl math test exited with status code %ERRORLEVEL%
    exit /b 1
)

(
    echo use File::Spec;
    echo my $path = File::Spec-^>catfile("a", "b"^);
    echo exit(1^) unless $path eq "a\\b";
) > test.pl

"%PACKIT_PACKAGE_PATH%\bin\perl.exe" test.pl
if ERRORLEVEL 1 (
    echo Test failed: perl file core module test exited with status code %ERRORLEVEL%
    exit /b 1
)
