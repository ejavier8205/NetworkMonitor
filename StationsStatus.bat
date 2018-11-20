@echo off

setlocal enabledelayedexpansion

:start
type top.html>StationsStatus.html
type nul>statustable.txt
set "CustomerID="



FOR /f "tokens=1,2,3,4,5 delims=," %%A in (Node1-status.txt) do (
    set "CustomerIP=%%B"
    if /i "!CustomerIP!" EQU "192.168.2.1" Set "CustomerID=LAB"
    if /i "!CustomerIP!" EQU "Disconnected" Set "CustomerID=Not Connected"
    if /i "!CustomerIP!" EQU "192.168.1.5" Set "CustomerID=AACPS"

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