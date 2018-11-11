@echo off

setlocal enabledelayedexpansion

:start
type top.html>StationsStatus.html
set "CustomerID="



FOR /f "tokens=1,2,3,4 delims=," %%A in (status.txt) do (
    set "CustomerIP=%%B"
    if /i "!CustomerIP!" EQU "192.168.8.1" Set "CustomerID=PWCS"
    if /i "!CustomerIP!" EQU "192.168.1.1" Set "CustomerID=GHOST"
    if /i "!CustomerIP!" EQU "192.168.1.5" Set "CustomerID=AACPS"

    echo ^<tr class="tableRows"^>>>StationsStatus.html
    echo ^<td id="!CustomerID!" class="customer"^>!CustomerID!^</td^>>>StationsStatus.html 
    echo ^<td id="StationID" class="station"^>%%A^</td^>>>StationsStatus.html
    echo ^<td id="CustomerIP" class="IP"^>%%B^</td^>>>StationsStatus.html
    echo ^<td id="DateID" class="Date"^>%%C^</td^>>>StationsStatus.html 
    echo ^</tr^>>>StationsStatus.html

    )
type bottom.html>>StationsStatus.html
timeout /t 5 >nul 2>nul
goto :start
endlocal