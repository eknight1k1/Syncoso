version 4.5


	-First version of Lite installer to use Network Share.

	-Updated Malwarebytes installer to version 2.2.1-1043.

	-Added a routine to create ROX, PCC, KRONOS and OWA shortcuts to the Public desktop.

	-Improved Adobe software check/installation routine.

	-Improved visual style.



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
