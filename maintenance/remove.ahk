MsgBox,4,Remove Stuff v1.2.1,This script written by Tyler Francis wants to remove a bunch of the junk programs that you probably don't want. It's pretty aggressive so you may want to review mr.txt to make sure you're ok with losing all of the programs and files listed therein. Are you ok with this?
IfMsgBox No
{
	MsgBox,0,Nothing Removed,Ok some other time maybe
	exitapp
}
else IfMsgBox Yes
{
	;; disable IE proxies
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
	Sleep, 500
	;; sets homepage to district website
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
	Sleep, 500
	
	;; Misc Removal Script setup
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
	Sleep 2000
	FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
	sleep 2000
	if A_OSVersion in WIN_XP
	{
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
	}
	RunWait %ComSpec% /C "c:\mr.bat"
	MsgBox,0,Successfully Cleaned,the Quick Clean process has completed., 20
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
}
