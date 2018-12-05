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


getmac /v /fo csv /nh>"%HomeDirectory%Nodes\Data\%Computername% Connected Adapters.txt"

type nul>"%HomeDirectory%Nodes\%computername% Active Connections.txt"


for /f "tokens=1,2,3 delims=," %%a in  ('TYPE "%HomeDirectory%Nodes\Data\%ComputerName% Adapters ID.txt"') do (
    Set MyAdaptersCount=0
    set NotFoundCount=0
    Set "AdapterName=%%a"
    Set "AdapterDesc=%%b"
    Set "AdapterMAC=%%c"

    Set AdapterName=!AdapterName:"=!
    Set AdapterDesc=!AdapterDesc:"=!
    Set AdapterMAC=!AdapterMAC:"=!

    for /f "tokens=1,2,3 delims=," %%a in  ('TYPE "%HomeDirectory%Nodes\Data\%computername% Connected Adapters.txt"') do (
        Set /a MyAdaptersCount+=1
    )

 

    for /f "tokens=1,2,3 delims=," %%a in  ('TYPE "%HomeDirectory%Nodes\Data\%computername% Connected Adapters.txt"') do (
        Set "MyAdapterName=%%a"
        Set "MyAdapterDesc=%%b"
        Set "MyAdapterMAC=%%c"

        Set MyAdapterName=!MyAdapterName:"=!
        Set MyAdapterDesc=!MyAdapterDesc:"=!
        Set MyAdapterMAC=!MyAdapterMAC:"=!

        if /i !MyAdapterMAC! == !AdapterMAC! (
            echo !AdapterName!,!MyAdapterName!,!MyAdapterMAC!>>"%HomeDirectory%Nodes\%computername% Active Connections.txt"
        ) else (
            Set /a NotFoundCount+=1
        )     

    )

        if /i !MyAdaptersCount! == !NotFoundCount! (
            echo !AdapterName!,Not Available,Not Available>>"%HomeDirectory%Nodes\%computername% Active Connections.txt"
        )

)

endlocal
exit /b