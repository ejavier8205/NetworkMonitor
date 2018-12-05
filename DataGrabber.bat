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


::  CHECK FOR NODE SET ADAPTERS 

        if exist "%HomeDirectory%Nodes\Data\%ComputerName% Adapters ID.txt" (
            goto :NodeDataFound
        ) else (
            echo.
            echo        Adapters data source for Node has not been set...script will exit.
            echo.
            pause >nul 2>nul
            exit

        )

:NodeDataFound
        call "%HomeDirectory%FindAdapter.bat"


        type nul>"%HomeDirectory%Nodes\status\%computername%-Status.txt"
pause
:: DISABLE AVAILABLE ADAPTERS
echo    Disabling connected adapters...
type "%HomeDirectory%Nodes\%computername% Active Connections.txt"
        for /f "tokens=1,2 delims=," %%a in ('type "%HomeDirectory%Nodes\%computername% Active Connections.txt"') do (
            set "SavedStationName=%%a"
            Set "StationName=%%b"
            echo !StationName! | findstr /i /v "Not Available" && netsh interface set interface "!StationName!" disable
        )
            

::ENABLE AVAILABLE ADAPTERS
echo    Enabling connected adapters...
      for /f "tokens=1,2,3 delims=," %%a in ('type "%HomeDirectory%Nodes\%computername% Active Connections.txt"') do (
            set "SavedStationName=%%a"
            Set "StationName=%%b"
            echo !StationName! | findstr /i /v "Not Available" && netsh interface set interface "!StationName!" enable
        )

::WAIT FOR 30 SECS TO OBTAIN IP AND GATEWAY
echo    Waiting for adapters to obtain IP...
        timeout /t 5 >nul 2>nul



for /f "tokens=1,2,3 delims=," %%a in ('type "%HomeDirectory%Nodes\%computername% Active Connections.txt"') do (

    set "SavedStationName=%%a"
    Set "StationName=%%b"
    Set "StationMAC=%%c"
    Set "NoConnection=Disconnected"

            echo !StationName! | findstr /i /v "Not Available"

            if %errorlevel% equ 0 (
                netsh interface ip show addresses name="!StationName!" | find /i "Default Gateway">"%Temp%\temp.txt"

                for /f "tokens=2 delims=:" %%a in  ('TYPE "%Temp%\temp.txt"') do (
                    set "gateway=%%a"
                    set "gateway=!gateway: =!"
                )

                set "MyTime=%time%"
                Set "MyTime=!MyTime: =!"
                if not defined Gateway Set "Gateway=Disconnected"
                echo !StationName!,!Gateway!,%date%,!Mytime!>>"%HomeDirectory%Nodes\status\%computername%-Status.txt"
            )

)

:SendData
set "CurrentTime=%time%"
set "CurrentTime=!CurrentTime: =!"
Set "CurrentTime=!CurrentTime:~6,-3!"
echo !CurrentTime!

if '!CurrentTime!' EQU '5' (
    xcopy "%HomeDirectory%Nodes\status\%computername%-Status.txt" "%HomeDirectory%Nodes\AllNodesCompilation\" /y
    pause
    echo data sent
    goto :start 
) else (
    goto :SendData
)

endlocal
