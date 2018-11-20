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

cd /d %HomeDirectory%


:start
TITLE Stations Status



type "%HomeDirectory%top.html">"%HomeDirectory%StationsStatus.html"
type nul>"%HomeDirectory%StatusTable.txt"
set "CustomerID="



FOR /f "tokens=1,2,3,4,5 delims=," %%A in ('TYPE "%HomeDirectory%Node1-status.txt"') do (
    set "CustomerIP=%%B"
    if /i "!CustomerIP!" EQU "192.168.2.1" Set "CustomerID=ASG LAB"
    if /i "!CustomerIP!" EQU "Disconnected" Set "CustomerID=Not Connected"
    if /i "!CustomerIP!" EQU "192.168.8.1" Set "CustomerID=PRINCE WILLIAM CO."
    if /i "!CustomerIP!" EQU "192.168.24.251" Set "CustomerID=GHOST"
    if /i "!CustomerIP!" EQU "192.168.0.1" Set "CustomerID=BALTIMORE CO."
    if /i "!CustomerIP!" EQU "10.255.248.1" Set "CustomerID=LOUDOUN CO."

    echo ^<tr class="tableRows"^>>>"%HomeDirectory%StatusTable.txt"

    echo ^<td id="!CustomerID!" class="customer"^>!CustomerID!^</td^>>>"%HomeDirectory%StatusTable.txt"

    echo ^<td id="StationID" class="station"^>%%A^</td^>>>"%HomeDirectory%StatusTable.txt"

    echo ^<td id="CustomerIP" class="IP"^>%%B^</td^>>>"%HomeDirectory%StatusTable.txt"

    echo ^<td id="DateID" class="Date"^>%%C^</td^>>>"%HomeDirectory%StatusTable.txt"

    echo ^<td id="TimeID" class="Time"^>%%D^</td^>>>"%HomeDirectory%StatusTable.txt"

    echo ^</tr^>>>"%HomeDirectory%StatusTable.txt"
    )
type "%HomeDirectory%statustable.txt">>"%HomeDirectory%StationsStatus.html"
type "%HomeDirectory%bottom.html">>"%HomeDirectory%StationsStatus.html"
timeout /t 1 >nul 2>nul
goto :start
endlocal