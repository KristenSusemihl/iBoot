@echo off

echo Loading...
title iBoot
timeout /t 3 /nobreak>nul
goto menu



:menu
cls
echo ==================
echo iBoot v1
echo [1] Reboot
echo [2] Shutdown
echo [3] Restore
echo [4] Backup Tools
echo [5] Credits
echo [6] Exit
echo ==================
set /p choice= Choose a option: 

if '%choice%' == '1' goto reboot
if '%choice%' == '2' goto shutdown
if '%choice%' == '3' goto restore
if '%choice%' == '4' goto backupTools
if '%choice%' == '5' goto credits
if '%choice%' == '6' exit

cls
echo Invalid Option! Press any key to go back to the menu.
pause>nul
goto menu

:reboot
cls
tools\idevicediagnostics restart
echo Done! Press any key to continue.
pause>nul
goto menu

:shutdown
cls
tools\idevicediagnostics shutdown
echo Done! Press any key to continue.
pause>nul
goto menu

:restore
cls
set /p ipswOption= Would you like to supply a iPSW? If you say no, the latest update for your device will be downloaded. (y or n): 
if '%ipswOption%' == 'y' goto restoreFromSupplied
if '%ipswOption%' == 'n' goto restoreFromLatest

:restoreFromSupplied
set /p ipsw= Choose a iPSW: 
set /p restoreOrUpdate= Would you like to restore your device to this firmware, or update your device to it? (restore or update): 
if '%restoreOrUpdate%' == 'restore' tools\idevicerestore %ipsw% -e
if '%restoreOrUpdate%' == 'update' tools\idevicerestore %ipsw%

del /f /s /q *.ipsw.lock>nul
del /f /s /q *.xml>nul
echo Done! Press any key to continue.
pause>nul
goto menu

:restoreFromLatest
set /p restoreOrUpdate= Would you like to restore your device to the latest firmware, or update your device to it? (restore or update): 
if '%restoreOrUpdate%' == 'restore' tools\idevicerestore -l -e
if '%restoreOrUpdate%' == 'update' tools\idevicerestore -l

del /f /s /q *.ipsw>nul
del /f /s /q *.ipsw.lock>nul
del /f /s /q *.xml>nul
echo Done! Press any key to continue.
pause>nul
goto menu

:backupTools
cls
set /p backupOrRestore= Would you like to backup or restore? (backup or restore): 
if '%backupOrRestore%' == 'backup' goto backupDevice
if '%backupOrRestore%' == 'restore' goto restoreFromBackup
cls

:backupDevice
cls
set /p backupFolder= What would you like to name your backup? 
mkdir %backupFolder%>nul
tools\idevicebackup backup %backupFolder% --full 
echo Done! Press any key to go back to the menu.
pause>nul
goto menu

:restoreFromBackup
cls
set /p restoreFolder= What backup would you like to restore to? 
tools\idevicebackup restore %restoreFolder% --system --reboot --settings
echo Done! Press any key to go back to the menu.
pause>nul
goto menu

:credits
cls
echo iBoot v1 by TheBeastGamer25
echo.
echo This project woudn't have been possbile without libimobiledevice and its creators.
echo Many thanks to them. <3
echo.
echo Press any key to go back to the menu.
pause>nul
goto menu