MsgBox,4,Install Firefox Internet Explorer 8 and Flash,click YES to install the latest version of Firefox Internet Explorer 8 and Flash
IfMsgBox No
MsgBox,0,Nothing Installed,Ok some other time maybe
else IfMsgBox Yes
{
    Run FirefoxSetup.exe -ms
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
	Sleep, 500
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
	Sleep, 500
;	RunWait flashplayerIE.exe
;	RunWait flashplayerFF.exe
	RunWait IE8-WindowsXP-x86-ENU.exe
	ifEqual, ErrorLevel, 7
		RunWait IE9-Windows7-x86-enu.exe
	else
		MsgBox, 0, FYI, You are not running Windows 7.,5
	sleep 4500
	MsgBox, 4, Kronos question, Is this a "Teacher Computer"?, 60
	IfMsgBox Yes
	{
		RunWait java6u24.exe
	}
	else IfMsgBox No
	{
		RunWait java.exe
	}
	else IfMsgBox TIMEOUT
	{
		RunWait java.exe
	}
	MsgBox, 3, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown or *NO* to restart. BTdubs the error level is "%ErrorLevel%"
	IfMsgBox Yes
	{
		Run %ComSpec% /C "shutdown -s -t 10"
		MsgBox, 4096, Shutdown, Alright--shutting down in 10..., 5
	}
	else IfMsgBox No
	{
		Run %ComSpec% /C "shutdown -r -t 10"
		MsgBox, 4096, Restart, Alright--restarting in 10..., 5
	}
}