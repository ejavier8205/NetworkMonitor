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
cls
title DataGrabber
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

Set StationID=0
set TotalStations=0
type nul>"%HomeDirectory%!NodeID!"

::GET GATEWAY
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NextStation
if '%TotalStations%' GTR 6 goto :start
Set /a StationID+=1
Set "StationName=Bench"
set count=0
:GetGateway
set /a count+=1
if '%count%' GTR 5 goto :NoGateway
netsh interface ip show addresses name="!StationName! !StationID!" | find /i "Default Gateway" >nul 2>nul && goto :SaveGateway || goto :GetGateway


:SaveGateway
netsh interface ip show addresses name="!StationName! !StationID!" | find /i "Default Gateway">>"%HomeDirectory%temp.txt"
for /f "tokens=2 delims=:" %%a in  ('TYPE "%HomeDirectory%temp.txt"') do (
    set "gateway=%%a"
    set "gateway=!gateway: =!"
)
set "MyTime=%time%"
Set "MyTime=!MyTime: =!"
echo !StationName! !StationID!,!Gateway!,%date%,!Mytime!>>"%HomeDirectory%!NodeID!"
set /a TotalStations+=1
goto :NextStation

:NoGateway
set "MyTime=%time%"
Set "MyTime=!MyTime: =!"
echo !StationName! !StationID!,!NoConnection!,%date%,!Mytime!>>"%HomeDirectory%!NodeID!"
set /a TotalStations+=1
goto :NextStation
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


endlocal
