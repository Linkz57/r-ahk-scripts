Run FirefoxSetup.exe -ms
Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
Sleep, 1000
Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
Sleep, 2000
Run shockwave.exe
;RunWait flashplayerIE.exe
;Run flashplayerFF.exe
;RunWait %ComSpec% /C "flashplayerIE.msi /passive"
;RunWait %ComSpec% /C "flashplayerFF.msi /passive"
RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
Sleep, 2000
FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
Run 200enters500msinc.exe
RunWait C:\mr.bat
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
RunWait %ComSpec% /C "adobereader.msi /passive"
RunWait IE8-WindowsXP-x86-ENU.exe
ifEqual, ErrorLevel, 7
	RunWait IE9-Windows7-x86-enu.exe
else
	MsgBox, 0, FYI, You are not running Windows 7.,5
Run %ComSpec% /C "del /F /Q c:\mr.bat"
MsgBox, 3, Alright you're done, Do you wanna shutdown or something? YES to shutdown or NO to restart. BTdubs the error level is "%ErrorLevel%"
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