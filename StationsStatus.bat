@echo off

setlocal EnableDelayedExpansion

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

@cd /d "%~dp0"


:start
TITLE Stations Status
type top.html>StationsStatus.html
type nul>statustable.txt
set "CustomerID="



FOR /f "tokens=1,2,3,4,5 delims=," %%A in (Node1-status.txt) do (
    set "CustomerIP=%%B"
    if /i "!CustomerIP!" EQU "192.168.2.1" Set "CustomerID=ASG LAB"
    if /i "!CustomerIP!" EQU "Disconnected" Set "CustomerID=Not Connected"
    if /i "!CustomerIP!" EQU "192.168.8.1" Set "CustomerID=PRINCE WILLIAM CO."
    if /i "!CustomerIP!" EQU "192.168.24.251" Set "CustomerID=GHOST"
    if /i "!CustomerIP!" EQU "192.168.0.1" Set "CustomerID=BALTIMORE CO."
    if /i "!CustomerIP!" EQU "10.255.248.1" Set "CustomerID=LOUDOUN CO."

    echo ^<tr class="tableRows"^>>>StatusTable.txt

    echo ^<td id="!CustomerID!" class="customer"^>!CustomerID!^</td^>>>StatusTable.txt

    echo ^<td id="StationID" class="station"^>%%A^</td^>>>StatusTable.txt

    echo ^<td id="CustomerIP" class="IP"^>%%B^</td^>>>StatusTable.txt

    echo ^<td id="DateID" class="Date"^>%%C^</td^>>>StatusTable.txt

    echo ^<td id="TimeID" class="Time"^>%%D^</td^>>>StatusTable.txt

    echo ^</tr^>>>StatusTable.txt
    )
type statustable.txt>>StationsStatus.html
type bottom.html>>StationsStatus.html
timeout /t 1 >nul 2>nul
goto :start
endlocal