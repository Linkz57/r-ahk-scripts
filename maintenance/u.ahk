MsgBox,4,Update Manually v1.0.1,This script written by Tyler Francis wants to install the latest version of "Firefox" "Flash" "Java" "Adobe Reader" and "Internet Explorer" as well as remove a few of the junk programs that you probably don't want. Are you ok with this?
IfMsgBox No
{
    MsgBox,0,Nothing Installed,Ok some other time maybe
	exitapp
}
else IfMsgBox Yes
{
	;; Install Firefox silently
	Run FirefoxSetup.exe -ms

	;; Remove Internet Explorer proxy settings
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
	Sleep 1000

	;; Change Internet Explorer homepage back to default
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
	Sleep 2000

	;; Shockwave
	Run shockwave.exe
	
	;; Flash Player Internet Explorer installation
	RunWait flashplayerIE.exe
	
	;; Flash Player Firefox plugin installation
	Run flashplayerFF.exe
	
	; RunWait %ComSpec% /C "flashplayerIE.msi /passive"
	; RunWait %ComSpec% /C "flashplayerFF.msi /passive"
	
	;; Misc Removal Script setup
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
	Sleep, 1000
	FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
	; Run 200enters500msinc.exe
	
	;; Misc Removal Script execution
	RunWait C:\mr.bat
	
	;; Java installation
	RunWait java.exe
	
	;; Adobe Reader installation
	RunWait %ComSpec% /C "adobereader.msi /passive"
	
	;; Internet Explorer installation
	if A_OSVersion in WIN_VISTA
	{
		RunWait %ComSpec% /C "IE9-Windows7-x86-enu.exe /passive /norestart"
	}
	if A_OSVersion in WIN_XP
	{
		RunWait %ComSpec% /C "IE8-WindowsXP-x86-ENU.exe /passive /norestart /sqm"
	}
	
	;; One Final cleanup
	Run %ComSpec% /C "del /F /Q c:\mr.bat"
	
	;; And finish
	MsgBox, 3, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown or *NO* to restart. BTdubs the error level is "%ErrorLevel%"
	IfMsgBox Yes
	{
		Run %ComSpec% /C "shutdown -s -t 10"
		MsgBox, 4096, Shutdown, Alright--shutting down in 10..., 5
        ExitApp
	}
	else IfMsgBox No
	{
		Run %ComSpec% /C "shutdown -r -t 10"
		MsgBox, 4096, Restart, Alright--restarting in 10..., 5
        ExitApp
    }
    
	esc::
	{
		Run %ComSpec% /C "explorer"
		ExitApp
	}
}