:: Backup script for Windows 7 / 10 / 11
:: ************************************************************************************/
@echo off & Title Backup or Restore Device Drivers by Z0ink5 & mode con cols=93 & color 17
(Net session >nul 2>&1)&&(cd /d "%~dp0")||(PowerShell start """%~0""" -verb RunAs & Exit /B)
:: ************************************************************************************/
echo. 
echo    Press (1) to back up all 3rd-party device drivers into a folder.
echo    Press (2) to restore all 3rd-party device drivers from a folder.
echo    Press (3) to restore a device driver backup via Device Manager.
:Choice
CHOICE /C "123" /M "Your choice?:" >nul 2>&1  
If %errorlevel%==1  (goto Option_1) & Exit
If %errorlevel%==2  (goto Option_2) & Exit
If %errorlevel%==3  (goto Option_3) & Exit
Exit
:Option_1
Call:✶ "Please select a folder or click on [Make new folder] first." SourceFolder
:✶
Set "✱="(new-object -COM 'Shell.Application').BrowseForFolder(0,'%1',0,0).self.path""
For /f "usebackq delims=" %%# in (`PowerShell %✱%`) do set "【Folder】=%%#"
If "%【Folder】%"=="" (Goto Choice & Exit) 
dism /online /export-driver /destination:"%【Folder】%"
Echo.&Echo    The device drivers have been exported to the following folder:
Echo    "%【Folder】%" & Echo.&Echo    Press any key to exit.
pause >nul & Exit
Exit
:Option_2
Call:✶ "Select the folder containing the device drivers previously exported." SourceFolder
:✶
Set "✱="(new-object -COM 'Shell.Application').BrowseForFolder(0,'%1',0x200,0).self.path""
For /f "usebackq delims=" %%# in (`PowerShell %✱%`) do set "【Folder】=%%#"
If "%【Folder】%"=="" (Goto Choice & Exit) 
Echo.
Echo    If necessary, the computer will be automatically restarted to complete the operation of
Echo    importing the drivers. Please save and close anything open and then press a key to start
Echo    the operation.
Echo.
pause >nul
pnputil /add-driver "%【Folder】%\*.inf" /subdirs /install /reboot
echo. & Echo    The process has completed successfully.
Echo    If the computer does not automatically reboot, you may press a key to exit.
pause >nul & Exit
Exit
:Option_3
Start "" "devmgmt.msc" & Exit
:: Backup script for Windows 7 / 10 / 11
::
:: Copy of this can be found on https://github.com/Z0ink5/SimpleBackupRestore-Windows-Drivers/
::
::
