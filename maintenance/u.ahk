MsgBox,4,Update Manually v1.3.1,This script written by Tyler Francis wants to install the latest version of "Firefox" "Flash" "Java" "Adobe Reader" and "Internet Explorer" as well as remove a few of the junk programs that you probably don't want. Are you ok with this?
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
	Runwait %ComSpec% /C "flashplayerIE.msi /qb /norestart"
	sleep 2000

	;; Flash Player Firefox plugin installation
	if A_OSVersion in WIN_XP
	{
		Runwait %ComSpec% /C "flashplayerFF.msi /qb /norestart"
	}
	if A_OSVersion in WIN_VISTA,WIN_7
	{
		Run flashplayerFF-old_win7.exe
	}

	;; Misc Removal Script setup
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
	Sleep 2000
	FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
	sleep 2000
	if A_OSVersion in WIN_XP
	{
		msgbox,48,Heads up,Hey hold on a second--this next bit is automated so don't touch anything,3
		sleep 2000
		Run %ComSpec% /C "notepad c:\mr.bat"
		sleep 3000
		send !{space}
		sleep 500
		send x
		sleep 1000
		
		;; replace homepath
		send ^h
		sleep 500
		send `%Homepath`%
		sleep 500
		send {tab}
		sleep 500
		send \Documents and Settings\student
		sleep 500
		send !a
		sleep 4500
		
		;; replace programdata
		send +{tab}
		sleep 500
		send `%ProgramData`%\Microsoft\Windows
		sleep 500
		send {tab}
		sleep 500
		send C:\Documents and Settings\All Users
		sleep 500
		send !a
		sleep 2000
		
		;; replace public
		send +{tab}
		sleep 500
		send `%PUBLIC`%
		sleep 500
		send {tab}
		sleep 500
		send C:\Documents and Settings\All Users
		sleep 500
		send !a
		sleep 2000
		
		;; finish replacement
		send !{F4}
		sleep 500
		send ^s
		sleep 500
		send !{F4}
		sleep 1000
		msgbox,0,OK we're good,See? That wasn't so bad. OK get back to clicking now.
	}
	sleep 1000
	

	;; Misc Removal Script execution
	RunWait %ComSpec% /C "C:\mr.bat"

	;; Java installation
	RunWait %ComSpec% /C "java.msi /passive /norestart"

	;; Adobe Reader installation
	RunWait %ComSpec% /C "adobereader.msi /qb /norestart"
	RunWait %ComSpec% /C "msiexec.exe /update "adobereaderpatch.msp" /qb /norestart

	;; Internet Explorer installation
	if A_OSVersion in WIN_7
	{
		Run %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411f00005308adba010000003000000001000000010000000c000000980f7f42a0e0ce010100000009006b0072006f006e006f0073002d0061007300" /F"
		RunWait %ComSpec% /C "IE11-W7.exe /passive /norestart"
	}
	if A_OSVersion in WIN_VISTA
	{
		RunWait %ComSpec% /C "IE9-vista.exe /passive /norestart"
	}
	if A_OSVersion in WIN_XP
	{
		RunWait %ComSpec% /C "IE8-XP.exe /passive /norestart /sqm"
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
