@echo off

::Deletes the Windows update custom script logon task and auto-logon task.
schtasks /delete /tn wutemp /f
schtasks /delete /tn autologon /f

::Removes auto-logon registry keys.
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d 0 /f
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /f
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /f
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ForceAutoLogon /f

shutdown /r /t 60

::Deletes the Syncoso PCB Program Files folder.
RD /S /Q "%programfiles%\Syncoso PCB"


exit
