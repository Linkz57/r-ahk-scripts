if A_OSVersion in WIN_7
{
	MsgBox,4,Install IE 11 - version 0.1 of this script, This script will install IE 11 and attempt to add Kronos to the compatibility view list. `nAre you down with this?
	IfMsgBox No
	{
		MsgBox,0,Nothing Installed,Ok some other time maybe,5
		exitapp
	}
	else
	{
		Run %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411f00005308adba010000003000000001000000010000000c000000980f7f42a0e0ce010100000009006b0072006f006e006f0073002d0061007300" /F"
		RunWait %ComSpec% /C "IE11-Windows6.1-x86-en-us.exe /passive /norestart"
		Run %ComSpec% /C "shutdown -r -t 10"
		sleep 1000
		MsgBox, 4096, Restart, Restarting now. Remember to check the compatibility list for Kronos-as, 5
		ExitApp
	}
}
else
{
	msgbox,0,Sorry bub,This only works on Windows 7
	exitapp
}
