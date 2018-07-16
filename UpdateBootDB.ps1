##Powershell script to run at server boot to update boot log database.

##Import the SQL Server CMDLET module.
Import-module sqlserver

##Read the last startup time from the event log and update the SvrBootLog table in the database.
$LastStartup = Get-EventLog -Log "System" | where {$_.eventID -eq 12} | Select-Object -first 1
Invoke-Sqlcmd -Query "UPDATE SvrBootLog SET SvrLastStart = $LastStartup.time" -ServerInstance "SQL03\MAIN"

##Read the last shutdown time from the event log and update the SvrBootLog table in the database.
$LastShutdown = Get-EventLog -Log "System" | where {$_.eventID -eq 13} | Select-Object -first 1
Invoke-Sqlcmd -Query "UPDATE SvrBootLog SET SvrLastShutdown = $LastShutdown.time" -ServerInstance "SQL03\MAIN"
