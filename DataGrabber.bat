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
::netsh interface set interface "Bench 1" disable
::netsh interface set interface "Bench 2" disable
::netsh interface set interface "Bench 3" disable
::netsh interface set interface "Bench 4" disable
::netsh interface set interface "Bench 5" disable
::netsh interface set interface "Bench 6" disable

::timeout /t 3 >nul 2>nul

::netsh interface set interface "Bench 1" enable
::netsh interface set interface "Bench 2" enable
::netsh interface set interface "Bench 3" enable
::netsh interface set interface "Bench 4" enable
::netsh interface set interface "Bench 5" enable
::netsh interface set interface "Bench 6" enable

timeout /t 5 >nul 2>nul


Set "NoConnection=Disconnected"
set "NodeID=Node1-Status.txt"


::STATION-1
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Set "StationID=Bench 1"
set count=0
:GetGateway
set /a count+=1
if '%count%' GTR 5 goto :NoGateway
netsh interface ip show addresses name="!StationID!" | find /i "Default Gateway" >nul 2>nul && goto :SaveGateway || goto :GetGateway


:SaveGateway
netsh interface ip show addresses name="!StationID!" | find /i "Default Gateway">>temp.txt
for /f "tokens=2 delims=:" %%a in  (temp.txt) do (
    set "gateway=%%a"
    set "gateway=!gateway: =!"
)
set "MyTime=%time%"
Set "MyTime=!MyTime: =!"
echo !StationID!,!Gateway!,%date%,!Mytime!>!NodeID!
goto :Station2

:NoGateway
set "MyTime=%time%"
Set "MyTime=!MyTime: =!"
echo !StationID!,!NoConnection!,%date%,!Mytime!>!NodeID!
goto :Station2
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::STATION-2
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:Station2
Set "StationID=Bench 2"
set count=0
:GetGateway
set /a count+=1
if '%count%' GTR 5 goto :NoGateway
netsh interface ip show addresses name="!StationID!" | find /i "Default Gateway" >nul 2>nul && goto :SaveGateway || goto :GetGateway


:SaveGateway
netsh interface ip show addresses name="!StationID!" | find /i "Default Gateway">>temp.txt
for /f "tokens=2 delims=:" %%a in  (temp.txt) do (
    set "gateway=%%a"
    set "gateway=!gateway: =!"
)
set "MyTime=%time%"
Set "MyTime=!MyTime: =!"
echo !StationID!,!Gateway!,%date%,!Mytime!>>!NodeID!
goto :Station3

:NoGateway
set "MyTime=%time%"
Set "MyTime=!MyTime: =!"
echo !StationID!,!NoConnection!,%date%,!Mytime!>>!NodeID!
goto :Station3
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:Station3
goto :start






endlocal
