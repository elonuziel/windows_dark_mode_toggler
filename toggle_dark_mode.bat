@echo off
setlocal

:: Registry keys for Light/Dark mode
set "REG_KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
set "APPS_VAL=AppsUseLightTheme"
set "SYSTEM_VAL=SystemUsesLightTheme"

:: Check the current theme state (Apps version)
set "CURRENT_MODE="
for /f "tokens=3" %%a in ('reg query "%REG_KEY%" /v %APPS_VAL% 2^>nul') do (
    set "CURRENT_MODE=%%a"
)

:: Toggle logic
if "%CURRENT_MODE%"=="0x1" (
    echo Switching to Dark Mode...
    reg add "%REG_KEY%" /v %APPS_VAL% /t REG_DWORD /d 0 /f >nul
    reg add "%REG_KEY%" /v %SYSTEM_VAL% /t REG_DWORD /d 0 /f >nul
) else (
    echo Switching to Light Mode...
    reg add "%REG_KEY%" /v %APPS_VAL% /t REG_DWORD /d 1 /f >nul
    reg add "%REG_KEY%" /v %SYSTEM_VAL% /t REG_DWORD /d 1 /f >nul
)

echo Done!
pause
