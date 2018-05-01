version 4.5


	-Updated Malwarebytes installer to version 2.2.1-1043.

	-Added a routine to create ROX, PCC, KRONOS and OWA shortcuts to the Public desktop.

	-Improved Adobe software check/installation routine.

	-Improved visual style.



version 4.2


	-Syntax fixes.

	-Changed O365 install directory to the DFSR share.



version 4.1


	-Added routine for installing Microsoft SCEP.



version 4.0


	-Redesigned script to be a general purpose software installation utility.

	-Added a routine to choose which particular software to install.

	-Removed Office 2010 source installation files. Office 2013 is now installed from a local share.

	-Updated Adobe Flash Player plugin to version 20. 



version 3.3


	-Improved IE credential handling for Intranet Zones.



version 3.2


	-Added bypass for Ctrl+Alt+Del during auto-logon.



version 3.1


	-Added considerations so the miniadmin account can be used to run the script.

	-Changed the password protection on the script installer archive.

	-Fixed credential storing with cmdkey during the Forefront installation.

	-Fixed credential passing and storing for SyncosoGROUP domain cases.

	-Script creates and empty folder labeled "[drivers]" on the root directory for future printer installations.



version 3.0


	-Merged 32 and 64 bit versions into one archive.

	-Added toggle for domain.



version 2.0


	-Now supports 64-bit (separate executeable).

	-Updated Malwarebytes installer.

	-Fixed sleep during update routines.

	-Internet Explorer defaults are now set across all users.

	-Installs Citrix Web plugin.



version 1.2


	-Switched back to secure version as primary version to allow flexibility in credential changes and maintain increased security.

	-Added an option to skip Windows product key entry and activation.



version 1.1


	-Changed auto-logon registry editing to a scheduled task that runs at startup.



version 1.0


	-Syntax fixes

	-Improved cleanup routines

	-Enforced auto-logon after applying Windows updates



version 0.5


	-Syntax fixes.

	-Corrected reboot after update install

	-Set updates to install 40 at a time

	-Switched to manual install for DameWare client



version 0.4


	-Fixed Google Chrome silent install

	-Corrected calls to external scripts

	-Added secure password capture for auto-logon routine

	-Changed install directory to "%programfiles%\Syncoso PCB"

	-Main script runs automatically after install (Run exe as administrator)



version 0.3


	-Modified main script flow text for better comprehension

	-Modified windows update script to disregard user prompts

	-Added a routine that automatically logs in as "facilities\support" upon reboot

	-Added a routine that creates a scheduled task to run windows updates on user logon

	-Modified the windows update script to remove the auto-logon and auto-update routines

		and delete the Syncoso PCB folder when there are no applicable updates



version 0.2


	-Removed silent mode for Windows Product Key installation

	-Added basic header information in the main batch script

	-Added explanatory lines of text for the various installation processes

	-Changed working folder to "Syncoso PCB"

	-Working folder will delete itself when the end of the script is reached

	-Added VBS script for running windows updates

	-Changed icon
