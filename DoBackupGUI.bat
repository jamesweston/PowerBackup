@ECHO OFF

ECHO ****** Check for drive *******
if not exist DESTDRIVE:\Run743584.id (
C:\PowerBackup\blat -body "Veeam USB Backup Faild Wrong Drive" -to toaddress@meamod.com -f fromaddress@meamod.com -s "Veeam USB Backup Faild Wrong Drive" -server mailserver.meamod.com
Exit
)

ECHO ****** Staring RoboCopy ******
Robocopy SOURCEDRIVE: DESTDRIVE: /e /copyall /r:5 /W:1 /mir /xd "System Volume Information" "$RECYCLE.BIN"


Echo ****** Sleeping for Eject ******

C:\PowerBackup\sleep -m 60000


Echo ****** Ejecting Drive ******

C:\PowerBackup\deveject -EjectId:"USB\VID_0BC2&PID_3320\NA4LCLMD"
C:\PowerBackup\deveject -EjectId:"USB\VID_0BC2&PID_3320\NA4MGRGP"


Echo ****** Sending Notification E-Mail ******

C:\PowerBackup\blat -body "Veeam USB Backup Complete" -to toaddress@meamod.com -f fromaddress@meamod.com -s "Veeam Backup to USB Complete" -server mailserver.meamod.com -attacht "C:\PowerBackup\Log.txt","C:\PowerBackup\PowerLog.txt"