@echo off

setlocal enabledelayedexpansion

:start
type top.html>StationsStatus.html
set "CustomerID="


sort status.txt>status_sorted.txt

FOR /f "tokens=1,2,3,4 delims=," %%A in (status_Sorted.txt) do (
    set "CustomerIP=%%B"
    if /i "!CustomerIP!" EQU "192.168.8.1" Set "CustomerID=PWCS"
    if /i "!CustomerIP!" EQU "192.168.1.1" Set "CustomerID=GHOST"
    if /i "!CustomerIP!" EQU "192.168.1.5" Set "CustomerID=AACPS"


    echo ^<div id="!CustomerID!" class="status"^>%%A  !CustomerID! %%B ^<a class="date"^>%%C^</a^>^</div^>>>StationsStatus.html

    )
type bottom.html>>StationsStatus.html
timeout /t 5 >nul 2>nul
goto :start
endlocal