@echo off
setlocal

echo Starting mitmproxy...
start "" /b cmd /c "mitmdump --mode local:parsecd.exe -s modify_response.py"
timeout /t 5 >nul

:: Wait for mitmproxy to start
:WAIT_FOR_MITMPROXY
tasklist | findstr /i "mitmdump.exe" >nul
if errorlevel 1 (
    timeout /t 1 >nul
    goto WAIT_FOR_MITMPROXY
)

echo Starting Parsec...
start "" "C:\Program Files\Parsec\parsecd.exe"

:: Wait a moment and capture the PID of the new Parsec process
timeout /t 2 >nul
for /f "tokens=2" %%a in ('tasklist /fi "imagename eq parsecd.exe" /fo list ^| findstr /i "PID"') do (
    if not defined PARSECPID (
        set PARSECPID=%%a
    )
)

:: Monitor that specific PID
:WAIT_FOR_PARSECD_PID
tasklist /fi "PID eq %PARSECPID%" | findstr /i "parsecd.exe" >nul
if errorlevel 1 (
    goto END
)
timeout /t 2 >nul
goto WAIT_FOR_PARSECD_PID

:END
echo Parsec PID %PARSECPID% has exited. Shutting down mitmproxy...
taskkill /f /im mitmdump.exe >nul 2>&1

echo Done.
endlocal
pause
