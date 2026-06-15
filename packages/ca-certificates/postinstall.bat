REM If openssl is not installed, just link cert.pem to cacert.pem
where openssl >nul
if ERRORLEVEL 1 (
    mklink "cert.pem" "cacert.pem" >nul
    exit /b 0
)
echo Found openssl, creating certificates bundle using system certificates

set "tempdir=%TEMP%\packit-ca-certificates-%RANDOM%-%RANDOM%"
mkdir %tempdir%
cd %tempdir%

REM Split the cacert.pem file into separate certificate files
powershell -NoProfile -Command "$i=0; $writer=$null; Get-Content '%PACKIT_PACKAGE_PATH%\cacert.pem' | ForEach-Object { if ($_ -match 'BEGIN CERTIFICATE') { $i++; $writer=[System.IO.StreamWriter]::new(\"cert_$i.pem\", $false) } if ($writer) { $writer.WriteLine($_) } if ($_ -match 'END CERTIFICATE') { $writer.Close(); $writer=$null } }; if ($writer) { $writer.Close() };"

certutil -split -store Root >nul

for %%i in (*.crt) do certutil -encode "%%i" "%%~ni.pem" >nul

type NUL >> fingerprints.txt
setlocal enabledelayedexpansion

for %%j in (*.pem) do (
	openssl x509 -inform pem -checkend 0 -noout < "%%j" >nul ^
	&& openssl x509 -text -noout < "%%j" > output.txt ^
	&& findstr /C:"CA:TRUE" output.txt >nul ^
	&& (
		for /f "delims=" %%A in ('openssl x509 -inform pem -fingerprint -sha256 -noout -in "%%j"') do set "fingerprint=%%A"
		
		findstr /C:"!fingerprint!" fingerprints.txt >nul
		if "!ERRORLEVEL!" == "1" (
			echo !fingerprint! >> fingerprints.txt
			type "%%j" >> "%PACKIT_PACKAGE_PATH%\cert.pem"
		)
	)
)
endlocal

cd "%PACKIT_PACKAGE_PATH%"
rmdir /s /q "%tempdir%"
