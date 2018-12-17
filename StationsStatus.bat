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

TITLE Stations Status


type nul>"%HomeDirectory%StatusTable.txt"


set "CustomerID="

FOR /f  %%A in ('dir "%HomeDirectory%Nodes\AllNodesCompilation" /b /A:-D') do (
    Set "NodeDataFile=%%A"


FOR /f "tokens=1,2,3,4,5 delims=," %%A in ('TYPE "%HomeDirectory%Nodes\AllNodesCompilation\!NodeDataFile!"') do (
    Set "StationName=%%A"
    set "CustomerIP=%%B"
    Set "CurrentDate=%%C"
    Set "CurrentTime=%%D"
    if /i "!CustomerIP!" EQU "192.168.2.1" Set "CustomerID=ASG Lab" && Set "CustomerAbbr=ASGLAB"
    if /i "!CustomerIP!" EQU "Disconnected" Set "CustomerID=Not Connected" && Set "CustomerAbbr=DISCONNECTED" && Set "RowID=DisconnectedRow"
    if /i "!CustomerIP!" EQU "192.168.8.1" Set "CustomerID=Prince William Co." && Set "CustomerAbbr=PWCS"
    if /i "!CustomerIP!" EQU "192.168.24.251" Set "CustomerID=Ghost" && Set "CustomerAbbr=GHOST"
    if /i "!CustomerIP!" EQU "192.168.0.1" Set "CustomerID=Baltimore Co." && Set "CustomerAbbr=BOE-BCPS"
    if /i "!CustomerIP!" EQU "10.255.248.1" Set "CustomerID=Loudoun Co." && Set "CustomerAbbr=LCPS"
    if /i "!CustomerIP!" EQU "192.168.16.250" Set "CustomerID=Anne Arundel Co." && Set "CustomerAbbr=AACPS"		

    echo !CustomerID!,!StationName!,!CustomerIP!,!CurrentDate!,!CurrentTime!>>"%HomeDirectory%StatusTable.txt"

    )

)






:SendData
    set "CurrentTime=%time%"
    ::set "CurrentTime=!CurrentTime: =!"
    Set "CurrentTime=!CurrentTime:~6,-3!"
    echo !CurrentTime!


if '!CurrentTime!' EQU '00' (
    type nul>"%HomeDirectory%Status.txt"
    type "%HomeDirectory%statustable.txt">>"%HomeDirectory%Status.txt"
    echo data sent
goto :start 
) else (
    goto :SendData
)


goto :start
endlocal