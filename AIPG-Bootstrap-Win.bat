@echo off

echo        ___                       ___           ___     
echo       /\  \          ___        /\  \         /\  \    
echo      /::\  \        /\  \      /::\  \       /::\  \   
echo     /:/\:\  \       \:\  \    /:/\:\  \     /:/\:\  \  
echo    /::\~\:\  \      /::\__\  /::\~\:\  \   /:/  \:\  \ 
echo   /:/\:\ \:\__\  __/:/\/__/ /:/\:\ \:\__\ /:/__/_\:\__\
echo   \/__\:\/:/  / /\/:/  /    \/__\:\/:/  / \:\  /\ \/__/
echo        \::/  /  \::/__/          \::/  /   \:\ \:\__\  
echo        /:/  /    \:\__\           \/__/     \:\/:/  /  
echo       /:/  /      \/__/                      \::/  /   
echo       \/__/                                   \/__/    

echo      ____  ____  ____  _____________________  ___    ____  ____  __________ 
echo     / __ )/ __ \/ __ \/_  __/ ___/_  __/ __ \/   ^|  / __ \/ __ \/ ____/ __ \
echo    / __  / / / / / / / / /  \__ \ / / / /_/ / /^| ^| / /_/ / /_/ / __/ / /_/ /
echo   / /_/ / /_/ / /_/ / / /  ___/ // / / _, _/ ___ ^|/ ____/ ____/ /___/ _, _/ 
echo  /_____/\____/\____/ /_/  /____//_/ /_/ ^|_/_/  ^|_/_/   /_/   /_____/_/ ^|_^|  
echo.
echo -------------------------------------------------------------------------------
echo.
echo Attention: Make sure that the QT wallet is fully closed before proceeding
echo .
pause

set "AipgPath=C:\Users\%UserName%\AppData\Roaming\Aipg"
cd /d "C:\Users\%UserName%\AppData\Roaming"


REM Check if Aipg folder exists
if not exist "Aipg" (
    mkdir "Aipg"
)
cd "Aipg"

REM Create temp folder within Aipg folder
if not exist "TEMP" (
    mkdir "TEMP"
)
cd "TEMP"

if not exist "bootstrap.zip" (
    echo Bootstrap not found, downloading...
    curl --progress-bar -O "https://files.aipowergrid.io/bootstrap.zip"
	echo .
)

echo Warning:
echo This script will delete all files in "%AipgPath%" except 'aipg.conf' and 'wallet.dat'.
echo.
set /p confirm=Do you want to proceed? (Y/N): 
if /i "%confirm%"=="Y" (
    echo Proceeding with deletion...
	for /f "tokens=*" %%F in ('dir /b "%AipgPath%"') do (
		if /i "%%F" neq "wallet.dat" (
			if /i "%%F" neq "aipg.conf" (
				if /i "%%F" neq "TEMP" (
					if exist "%AipgPath%\%%F" (
						rd /s /q "%AipgPath%\%%F" 2>nul
						del /q "%AipgPath%\%%F" 2>nul
					)
				)
			)
		)
	)
) else (
    echo Operation canceled.
	pause
	exit /b
)


REM Unzip the file
echo.
echo Unzipping Bootstrap file...
tar -xf "bootstrap.zip" -C "%AipgPath%"
echo.
echo ---------------------------------------
echo Your AIPG wallet has been Bootstrapped!
pause