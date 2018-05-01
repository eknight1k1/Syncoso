@echo off
echo.
color 1f
echo /**************************************************
echo /* Syncoso Group Facilities PC Builder version 4.5 *
echo /**************************************************
echo.
echo THIS INSTALLER PACKAGE IS INTENDED ONLY FOR INTERNAL USE AT Syncoso GROUP INC.
echo.

::This block initializes variables used to determine if an installation routine is run.
set run_wact=1
set run_dw=1
set run_office=1
set run_adobe=1
set run_citrix=1
set run_chrome=1
set run_mbam=1
set run_java=1
set j6u6_inst=1
set j6u24_inst=1
set run_scep=1
set run_ieset=1
set run_wu=1

::This block determines if the OS is x86 or x64 and saves it as a variable to be used in later subroutines for proper installation.
::This block is here for legacy purposes and can be phased out when the environment is fully 64-bit.
echo Determining operating system architecture...
if "%processor_architecture%"=="x86" (set bitness=32) else set bitness=64
echo Operating System is %bitness% bit
echo.

::This block defines the location of the source installation files depending on the OS architecture.
::It then creates an empty folder in the root directory for future printer installations and prevents the machine from sleeping.
:prep
set "initdir64=%programfiles(x86)%\Syncoso PCB"
set "initdir=%programfiles%\Syncoso PCB"
mkdir c:\[drivers]
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
echo Current working directory:
echo %cd%
echo.
powercfg /x -standby-timeout-ac 0
powercfg /x -standby-timeout-dc 0
echo Machine set to prevent sleep mode.
echo.

::The input from this block represents the domain and domain admin accounts that will be used to install software in later subroutines.
::It also takes the miniadmin account into consideration.
set /P domain= "Select domain. SyncosoGROUP or FACILITIES (a/f) "
if /I "%domain%" EQU "A" set login=SyncosoGROUP & set account=serverservice
if /I "%domain%" EQU "F" set login=FACILITIES & set account=support
set /P admincheck= "Are you using the miniadmin account (y/n)? "
if /I "%admincheck%" EQU "Y" set login=FACILITIES & set account=miniadmin
if /I "%admincheck%" EQU "N" goto:captpass
echo.

:captpass
::The next line calls a routine to capture the domain admin account password.
call:getpass

::This function handles the variables from the "getpass" function and stores it as text files to be used later.
::Saves the information in plain text within the Syncoso PCB Program Files folder for reference in other scripts.
:choice
echo %pass%>"%userprofile%\Desktop\support.txt"
if "%bitness%"=="64" (echo %pass%>"%initdir64%\scripts\support.txt") else (echo %pass%>"%initdir%\scripts\support.txt")
if "%bitness%"=="64" (echo %login%>"%initdir64%\scripts\login.txt") else (echo %login%>"%initdir%\scripts\login.txt")
if "%bitness%"=="64" (echo %account%>"%initdir64%\scripts\account.txt") else (echo %account%>"%initdir%\scripts\account.txt")
echo Password output to support.txt on the Desktop
set /P c= "Is this the correct password (y/n)? "
echo.
del %userprofile%\Desktop\support.txt
if /I "%c%" EQU "Y" goto:setopmode
if /I "%c%" EQU "N" call:getpass

::This block prompts the user to choose if a full or partial software installation should be run.
:setopmode
cls
echo.
echo /******************
echo /* OPERATION MODE *
echo /******************
echo.
echo.
echo "Go through EVERY routine." (TYPE 'e')
echo "Let me PICK and choose." (TYPE 'p')
echo.
set /p opmode= "CHOOSE 'E' or 'P' "
echo.
if /I "%opmode%" EQU "e" cls & goto:wact
if /I "%opmode%" EQU "p" goto:selectsteps

::This block allows the user to accept or decline installation/setup of each item in the installer.
:selectsteps
echo.
set /p ask_wact= "Do you want to install/check WINDOWS ACTIVATION (y/n)? "
if /I "%ask_wact%" EQU "Y" set run_wact=1 & echo WINDOWS ACTIVATION check confirmed.
if /I "%ask_wact%" EQU "N" set run_wact=0 & echo WINDOWS ACTIVATION check declined.
echo.
set /p ask_dw= "Do you want to install/check DAMEWARE (y/n)? "
if /I "%ask_dw%" EQU "Y" set run_dw=1 & echo DAMEWARE check confirmed.
if /I "%ask_dw%" EQU "N" set run_dw=0 & echo DAMEWARE check declined.
echo.
set /p ask_office= "Do you want to install/check OFFICE (y/n)? "
if /I "%ask_office%" EQU "Y" set run_office=1 & echo OFFICE check confirmed.
if /I "%ask_office%" EQU "N" set run_office=0 & echo OFFICE check declined.
echo.
set /p ask_adobe= "Do you want to install/check ADOBE (y/n)? "
if /I "%ask_adobe%" EQU "Y" set run_adobe=1 & echo ADOBE check confirmed.
if /I "%ask_adobe%" EQU "N" set run_adobe=0 & echo ADOBE check declined.
echo.
set /p ask_citrix= "Do you want to install/check CITRIX (y/n)? "
if /I "%ask_citrix%" EQU "Y" set run_citrix=1 & echo CITRIX check confirmed.
if /I "%ask_citrix%" EQU "N" set run_citrix=0 & echo CITRIX check declined.
echo.
set /p ask_chrome= "Do you want to install/check CHROME (y/n)? "
if /I "%ask_chrome%" EQU "Y" set run_chrome=1 & echo CHROME check confirmed.
if /I "%ask_chrome%" EQU "N" set run_chrome=0 & echo CHROME check declined.
echo.
set /p ask_mbam= "Do you want to install/check MALWAREBYTES (y/n)? "
if /I "%ask_mbam%" EQU "Y" set run_mbam=1 & echo MALWAREBYTES check confirmed.
if /I "%ask_mbam%" EQU "N" set run_mbam=0 & echo MALWAREBYTES check declined.
echo.
set /p ask_java= "Do you want to install/check JAVA (y/n)? "
if /I "%ask_java%" EQU "Y" set run_java=1 & echo JAVA check confirmed.
if /I "%ask_java%" EQU "N" set run_java=0 & echo JAVA check declined.
echo.
set /p ask_ieset= "Do you want to change/check IE SETTINGS (y/n)? "
if /I "%ask_ieset%" EQU "Y" set run_ieset=1 & echo IE SETTINGS check confirmed.
if /I "%ask_ieset%" EQU "N" set run_ieset=0 & echo IE SETTINGS check declined.
echo.
set /p ask_scep= "Do you want to install/check System Center Endpoint Protection (SCEP) client (y/n)? "
if /I "%ask_scep%" EQU "Y" set run_scep=1 & echo SCEP check confirmed.
if /I "%ask_scep%" EQU "N" set run_scep=0 & echo SCEP check declined.
echo.
set /p ask_wu= "Do you want to run WINDOWS UPDATE (y/n)? "
if /I "%ask_wu%" EQU "Y" set run_wu=1 & echo WINDOWS UPDATE check confirmed.
if /I "%ask_wu%" EQU "N" set run_wu=0 & echo WINDOWS UPDATE check declined.
cls

::This block prompts for a Windows product key and activates Windows.
:wact
if %run_wact%==0 goto:dw
echo.
echo /**********************
echo /* WINDOWS ACTIVATION *
echo /**********************
echo.
set /p key= "Enter Windows 7 Product Key (include dashes) OR type 's' to skip activation: "
echo.
if /I "%key%" EQU "S" goto:dw
%windir%\system32\slmgr.vbs /ipk %key%
%windir%\system32\slmgr.vbs /ato

::This block installs and starts the DameWare client service, then displays the IP address.
:dw
echo.
echo /*************************
echo /* DAMEWARE INSTALLATION *
echo /*************************
echo.
if %run_dw%==0 goto:shortcuts
if exist "%windir%\dwrcs" echo DameWare already installed. & goto:shortcuts
echo Installing DameWare client...
if "%bitness%"=="64" (cd "%initdir64%\sources\dw64") else (cd "%initdir%\sources")
xcopy dwrcs "%windir%\dwrcs" /D /E /C /R /I /K /Y
cd %windir%\dwrcs
start /wait dwrcs.exe -install
Net Start DWMRCS
netsh advfirewall set allprofiles state off
set ip_address_string="IPv4 Address"
echo Successfully installed DameWare client.
echo.
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo Your IP Address is: %%f

::This block creates shortcuts for RehabOptima, KRONOS, PCC, and O365 in the public desktop folder.
:shortcuts
echo.
echo /*********************
echo /* SHORTCUT CREATION *
echo /*********************
echo.
echo Creating common shortcuts...
if "%bitness%"=="64" (cd "%initdir64%\sources") else (cd "%initdir%\sources")
xcopy [icons] "C:\[icons]" /D /E /C /R /I /K /Y
xcopy shortcuts "C:\Users\Public\Desktop" /D /E /C /R /I /K /Y
echo Common shortcuts created.

::This block installs and activates MS Office 2013 (Office365 Pro Plus).
:office
echo.
echo /*********************************
echo /* MICROSOFT OFFICE INSTALLATION *
echo /*********************************
echo.
if %run_office%==0 goto:adobe
if exist "%programfiles%\Microsoft Office 15" echo Office 2013 already installed. & goto:adobe
echo Installing Office 365 Pro Plus (Office 2013)...
start /wait \\Syncosogroup.local\Public\IT\O365_deploy\setup.exe /configure \\Syncosogroup.local\Public\IT\O365_deploy\Syncoso.xml
echo Office 365 Pro Plus installed.

::The next two blocks install Adobe products.
::Adobe Reader presets are configured in the AcroRead.mst file.
:adobe
echo.
echo /*******************************
echo /* ADOBE SOFTWARE INSTALLATION *
echo /*******************************
echo.
if %run_adobe%==0 goto:citrix
if exist "%programfiles(x86)%\Adobe\Reader 11.0" echo Adobe Reader already installed. & goto:adobef
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd sources\Adobe_Reader
echo Installing Adobe Reader XI. Please wait...
start /wait setup.exe
echo Adobe Reader XI installation procedure completed.
echo.
:adobef
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd sources
echo Installing Adobe Flash Player ActiveX plugin...
start /wait install_flash_player_20_active_x.exe -install
echo Adobe Flash Player installed.

::This block installs the Citrix Web plugin.
:citrix
echo.
echo /******************************
echo /* CITRIX PLUGIN INSTALLATION *
echo /******************************
echo.
if %run_citrix%==0 goto:chrome
if exist "%programfiles(x86)%\Citrix" echo Citrix web plugin already installed. & goto:chrome
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd sources
echo Installing Citrix Web plugin...
start /wait CitrixWeb.exe /silent
echo Citrix Web plugin successfully installed

::This block installs Google Chrome.
:chrome
echo.
echo /******************************
echo /* GOOGLE CHROME INSTALLATION *
echo /******************************
echo.
if %run_chrome%==0 goto:mbam
if exist "%programfiles(x86)%\Google\Chrome" echo Google Chrome already installed. & goto:mbam
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd sources
echo Installing Google Chrome...
start /wait ChromeStandaloneSetup.exe /silent /install
echo Google Chrome installed.

::This block installs Malwarebytes free version.
::The executable can be replaced with a newer version.
:mbam
echo.
echo /*****************************
echo /* MALWAREBYTES INSTALLATION *
echo /*****************************
echo.
if %run_mbam%==0 goto:java
if exist "%programfiles(x86)%\Malwarebytes Anti-Malware" echo Malwarebytes already installed. & goto:java
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd sources
echo Installing Malwarebytes Free...
start /wait MBAM221_1043.exe /silent /norestart
echo Malwarebytes Free installed

::This block installs JRE 6 updates 6 and 24 for KRONOS and HRMS.
::It also disables the automatic updates and notifications for Java.
::JRE 6u24 is set to the default IE plugin.
:java
echo.
echo /**********************
echo /* JAVA CONFIGURATION *
echo /**********************
echo.
if %run_java%==0 goto:scep
if exist "%programfiles(x86)%\Java\jre1.6.0_06" set j6u6_inst=0 & echo Java 6u6 already installed.
if exist "%programfiles(x86)%\Java\jre1.6.0_24" set j6u24_inst=0 & echo Java 6u24 already installed.
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd sources
if %j6u6_inst%==1 echo Installing Java Runtime Environment version 6 update 6 (32-bit)... & start /wait jre-6u6-windows-i586-p.exe /lang=1033 /s
if %j6u24_inst%==1 echo Installing Java Runtime Environment version 6 update 24 (32-bit)... & start /wait jre-6u24-windows-i586-s.exe /lang=1033 /s IEXPLORER=1 STATIC=1
echo Java RE 6u6 and 6u24 installed
echo.
reg add "HKLM\Software\JavaSoft\Java Update\Policy" /v EnableJavaUpdate /t REG_DWORD /d 0 /f
reg add "HKLM\Software\JavaSoft\Java Update\Policy" /v NotifyDownload /t REG_DWORD /d 0 /f
if "%bitness%"=="64" reg add "HKLM\Software\Wow6432Node\JavaSoft\Java Update\Policy" /v EnableJavaUpdate /t REG_DWORD /d 0 /f
if "%bitness%"=="64" reg add "HKLM\Software\Wow6432Node\JavaSoft\Java Update\Policy" /v NotifyDownload /t REG_DWORD /d 0 /f
echo.
echo Disabled Java automatic updates and notifications

::This block installs SCEP client.
:scep
echo.
echo /***********************************************
echo /* MICROSOFT SYSTEM CENTER ENDPOINT PROTECTION *
echo /***********************************************
echo.
if %run_scep%==0 goto:setIE
if exist "%programfiles%\Microsoft Security Client" echo Microsoft SCEP already installed. & goto:setIE
echo Installing Microsoft System Center Endpoint Protection...
"\\crpscep001\sources\Packages\SCCM Client\scepinstall.exe" /s /q /NoSigsUpdateAtInitialExp
echo Microsoft SCEP successfully installed

::This block sets the Internet Explorer defaults for the local machine.
::This block exists for legacy purposes and should be removed once the GPO for IE settings is perfected.
:setIE
echo.
echo /***********************************
echo /* INTERNET EXPLORER CONFIGURATION *
echo /***********************************
echo.
if %run_ieset%==0 goto:wupdate
echo Setting default Internet Explorer setting for Syncoso Group:
echo.
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\Syncosogroup.com\connect" /v * /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\Syncosogroup.com\focus" /v https /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Internet Explorer\MAIN" /v Default_Page_URL /t REG_SZ /d http://corporate /f
reg add "HKLM\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /t REG_SZ /d http://corporate /f
if "%bitness%"=="64" reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v 1A00 /t REG_DWORD /d 0 /f
if "%bitness%"=="64" reg add "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\MAIN" /v Default_Page_URL /t REG_SZ /d http://corporate /f
if "%bitness%"=="64" reg add "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\MAIN" /v "Start Page" /t REG_SZ /d http://corporate /f
echo.
echo Set default homepage and intranet settings for Internet Explorer.

::This block modifies the registry to automatically log into Windows under the domain admin.
::It also creates scheduled tasks to run the same registry edit at system startup, as well as running the update script at user logon.
:wupdate
echo.
echo /****************************************
echo /* WINDOWS UPDATE AND AUTOMATIC RESTART *
echo /****************************************
echo.
if %run_wu%==0 goto:finish
echo Adding registry keys for automatic logon:
echo.
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d %account% /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d %login% /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d %pass% /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d 1 /f
::remove the next line if there are issues
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ForceAutoLogon /t REG_SZ /d 1 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoLogonChecked" /v "" /t REG_SZ /d 1 /f
echo.
echo Successfully set automatic logon for support account.
echo.
if "%bitness%"=="64" call:64schedule 
if "%bitness%"=="32" call:schedule

::This block runs the custom Windows update script.
::The script will install up to 50 updates at a time and reboot the computer; which will auto-login as the previously specified admin account.
::When there are no more updates, the script will delete the Syncoso PCB directory.
::It also resets the Winlogon registry keys to normal.
:script
echo.
echo Starting windows Update...
if "%bitness%"=="64" (cd "%initdir64%") else (cd "%initdir%")
cd scripts
if "%bitness%"=="64" (CSCRIPT update64.vbs) else (CSCRIPT update.vbs)
goto:finish

::This function captures input for the domain admin password as secure string by using powershell.
:getpass
echo.
echo Please enter the password for the %account% account.
echo (PLEASE WAIT FOR 'ENTER PASSWORD' PROMPT)
set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set pass=%%p
echo.
goto:choice

:64schedule
echo.
schtasks /create /f /sc onstart /tn autologon /ru SYSTEM /tr "\"%programfiles(x86)%\Syncoso PCB\scripts\autologon64.bat\""
schtasks /create /f /sc onlogon /tn wutemp /rl highest /tr "\"%programfiles(x86)%\Syncoso PCB\scripts\wutemp64.bat\""
echo Successfully set automatic Windows update task at logon.
echo.
goto:script

:schedule
echo.
schtasks /create /sc onstart /tn autologon /ru SYSTEM /tr "\"%programfiles%\Syncoso PCB\scripts\autologon.bat\""
schtasks /create /sc onlogon /tn wutemp /rl highest /tr "\"%programfiles%\Syncoso PCB\scripts\wutemp.bat\""
echo Successfully set automatic Windows update task at logon.
echo.
goto:script


:finish
echo.
echo /************************
echo /* OPERATIONS COMPLETED *
echo /************************
echo.
pause
exit
