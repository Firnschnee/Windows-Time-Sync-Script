@echo off

:check_internet
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% equ 0 goto sync_time
timeout /t 5 /nobreak >nul
goto check_internet

:sync_time
w32tm /resync /force >nul 2>&1
if %errorlevel% equ 0 (
    echo [%date% %time%] Time synced OK >> %SYSTEMROOT%\Logs\timesynced.log
) else (
    echo [%date% %time%] Time sync FAILED - check admin rights >> %SYSTEMROOT%\Logs\timesynced.log
)
exit /b 0