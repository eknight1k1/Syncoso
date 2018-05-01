@echo off

::Reads saved support password from text file and loads into a variable.
set "initdir=%programfiles%\Syncoso PCB"
cd %initdir%\scripts
set /p pass=<support.txt
set /p login=<login.txt
set /p account=<account.txt

::Sets auto-logon registry keys in case a Windows update re-wrote them.
echo Adding registry keys for automatic logon:
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d %account% /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d %login% /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d %pass% /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d 1 /f
::remove the next line if there are issues
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ForceAutoLogon /t REG_SZ /d 1 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoLogonChecked" /v "" /t REG_SZ /d 1 /f
echo Successfully set automatic logon for support account.
echo.

exit
