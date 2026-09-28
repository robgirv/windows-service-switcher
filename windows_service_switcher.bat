:: Switches between Windows services by stopping one and starting the other to resolve conflicts in different use cases

@echo off

:: Service names
set "service_one=MariaDB"
set "service_two=MySQL80"

:: Check if script has required privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ====================================================
    echo ERROR: Missing required privileges.
    echo ====================================================
    echo Script requires administrator privileges to handle system services.
    echo.
    pause
    exit /b
)

echo Checking database services...
echo.

:: Check if service one is running
sc query "%service_one%" | findstr /I "STATE" | findstr /I "RUNNING" >nul
if %errorLevel% equ 0 (
    echo [!] %service_one% is currently RUNNING.
    echo [.] Stopping %service_one%...
    net stop "%service_one%"
    echo.
    echo [.] Starting %service_two%...
    net start "%service_two%"
    goto end
)

:: Check if service two is running
sc query "%service_two%" | findstr /I "STATE" | findstr /I "RUNNING" >nul
if %errorLevel% equ 0 (
    echo [!] %service_two is currently RUNNING.
    echo [.] Stopping %service_two%...
    net stop "%service_two%"
    echo.
    echo [.] Starting %service_one%...
    net start "%service_one%"
    goto end
)

:: Start service one by default if both are stopped
echo [!] Both services are currently STOPPED.
echo [.] Starting service one (%service_one%) by default...
net start "%service_one%"

:end
echo.
echo ====================================================
echo Service switch complete!
echo ====================================================
echo.
pause
