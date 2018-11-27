@echo off
setlocal EnableDelayedExpansion
set HomeDirectory=%~dp0%
:checkPrivileges
NET FILE 1>NUL 2>NUL
IF '%errorlevel%' == '0' ( GOTO :gotPrivileges ) else ( GOTO :getPrivileges )

:getPrivileges
IF '%1'=='ELEV' (shift & GOTO :gotPrivileges)
ECHO.
ECHO *****************
ECHO Invoking UAC For Privilege Escalation
ECHO *****************

setlocal DisableDelayedExpansion
SET "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO SET UAC = CreateObject^("Shell.Application"^) > "%temp%\UAC.vbs"
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\UAC.vbs"
"%temp%\UAC.vbs"
exit \B

:gotPrivileges

cd /d "%HomeDirectory%"

:start

getmac /v /fo list>"%HomeDirectory%Nodes\%Computername% Connected Adapters.txt"



for /f "tokens=1,2,3,4 delims=," %%a in  ('TYPE "%HomeDirectory%Nodes\%computername% Adapters ID.txt"') do (
    Set "AdapterName=%%a"
    Set "AdapterDesc=%%b"
    Set "AdapterMAC=%%c"
    Set "AdapterTCPID=%%d"

    Set AdapterName=!AdapterName:"=!

    echo --!AdapterName!--      !AdapterDesc!       !AdapterMAC!        !AdapterTCPID!

)

for /f "tokens=2 delims=:" %%a in  ('TYPE "%HomeDirectory%Nodes\%computername% Connected Adapters.txt"') do (
    echo --%%a--)
    pause
endlocal