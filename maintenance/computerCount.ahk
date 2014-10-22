;; Computer Count v2.0.1
;; Written by Tyler Francis, started on 2014-10-22 at 10-52-01
;; The goal of this script is to collect all of the information I can from all of the computers we have at Humble High School. This info will mostly be used for inventory, but I can also see it being used for troubleshooting. For example, walking a user through changing their resolution is different in Windows XP than it is in Windows 7.

reg = open

msgbox,0,Ready?,I'm about to collect information about your computer. `n`nThis will mostly be used for inventory`, but I can also see it being used for troubleshooting computer problems you might call me about.,15
settitlematchmode,2
ifwinnotexist,Novell GroupWise - 
{
	run C:\Novell\GroupWise\grpwise.exe
	SetTimer,movelogin,-1000
	msgbox,4096,Two more things,Please log into GroupWise.,10
	winwait,Novell GroupWise - 
	sleep 5000
}
WinMinimize,Novell GroupWise - 
inputbox,roomnumber,One more thing,Excellent`, thank you. `n`nOne last thing`: what is your room number?,,,,,,,600,Mah Room Number

msgbox,0,Alright`, hands off,OK that's all I need`, thank you. Sit back`, relax`, and under no circumstances touch the mouse or keyboard!`n`nAll of this is automated`, so keep your hands to yourself until I give you the all-clear at the end.,30
IfMsgBox OK
{
	msgbox,48,WOA WOA WOA,What did I JUST tell you??`n`nHands off`, bro. Stand up and walk away if you have to. Just stop touching things for like 5 minutes.,10
	IfMsgBox OK
	{
		msgbox,16,You know what? Fine.,If we're going to have a problem following directions`, then I'm not even going to try. `n`nLaunch this program again when you're ready to take this seriously.,20
		exitapp
	}
}


;; Check IE version
RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
sleep 1000
RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Internet Explorer" /V "svcVersion" > C:\ci.txt"
sleep 1000
; SizeCheck
FileGetSize, ciSize, C:\ci.txt
;msgbox,0,0,size is %Size%
if (ciSize < 5) ; less than 5B
{
	RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
	sleep 1000
	RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Internet Explorer" /V "Version" > C:\ci.txt"
	sleep 1000
	FileGetSize, ci2Size, C:\ci.txt
	if (ci2Size < 5) ; less than 5B
	{
		reg = registryLocked
		goto,afterreg
	}
}

Run %ComSpec% /C "notepad c:\ci.txt"
sleep 1000
send !{space}
sleep 500
send x
sleep 500
send ^h
sleep 1000
send HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer
sleep 500
send !a
sleep 1000
send +{home}
sleep 500
send REG_SZ
sleep 500
send {tab}
sleep 500
send {=}
sleep 500
send !a
sleep 500
send +{tab}
sleep 500
send Version
sleep 500
send {tab}
sleep 500
send Internet Explorer Version
sleep 500
send !a
sleep 500
send !{F4}
msgbox,0,Hey listen,This is your version of Internet Explorer,3
settitlematchmode,3
IfWinExist,ci.txt - Notepad
	{
		WinActivate
		send ^a
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 500
		send !n
	}
ieversion = %Clipboard%
; msgbox,0,0,ieversion is '%ieversion%'
RunWait %ComSpec% /C "del /F /Q c:\ci.txt"






;; check Windows version
;windowscheck:
RunWait %ComSpec% /C "del /F /Q c:\cw.txt"
sleep 1000
RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V "ProductName" > C:\cw.txt"
sleep 1000
RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V "CSDVersion" >> C:\cw.txt"
; SizeCheck
FileGetSize, cwSize, C:\cw.txt
;msgbox,0,0,size is %Size%
if (cwSize < 10) ; less than 10B
{
	RunWait %ComSpec% /C "del /F /Q c:\cw.txt"
	msgbox,0,GAH! PANIC,someone set us up the errorlevel
	exitapp
}

Run %ComSpec% /C "notepad c:\cw.txt"
sleep 1000
send !{space}
sleep 500
send x
sleep 500
send ^h
sleep 1000
send HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion
sleep 500
send {tab}
sleep 500
send {backspace}
send !a
sleep 1000
send +{tab}
sleep 500
send REG_SZ
sleep 500
send {tab}
sleep 500
send {=}
sleep 500
send !a
sleep 500
send +{tab}
sleep 500
send ProductName
sleep 500
send {tab}
sleep 500
send Microsoft Windows Version
sleep 500
send !a
sleep 500
send +{tab}
sleep 500
send CSDVersion
sleep 500
send {tab}
sleep 500
send Windows Service Pack Version
sleep 500
send !a
sleep 500
send !{F4}
msgbox,0,Hey listen,This is your version of Microsoft Windows,3
settitlematchmode,3
IfWinExist,cw.txt - Notepad
	{
		WinActivate
		send ^a
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 500
		send !n
	}
winversion = %Clipboard%
;msgbox,0,0,winversion is '%winversion%'
RunWait %ComSpec% /C "del /F /Q c:\cw.txt"






;; check Resolution
;rescheck:
RunWait %ComSpec% /C "del /F /Q c:\cr.txt"
sleep 1000
RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Settings\Video" /s > C:\cr.txt"
; SizeCheck
FileGetSize, cwSize, C:\cr.txt
;msgbox,0,0,size is %Size%
if (cwSize < 10) ; less than 10B
{
	RunWait %ComSpec% /C "del /F /Q c:\cr.txt"
	msgbox,0,GAH! PANIC,someone set us up the errorlevel
	exitapp
}

Run %ComSpec% /C "notepad c:\cr.txt"
sleep 1000
send !{space}
sleep 500
send x
sleep 500
send ^h
sleep 1000
send HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Settings\Video
sleep 500
; send {tab}
; sleep 500
; send {backspace}
send !a
sleep 1000
send !{F4}
sleep 500
send {delete}
sleep 500
send +{end}
sleep 500
send ^c
sleep 500
send ^h
sleep 500
send ^v
sleep 500
send !a
sleep 500
send +{home}
sleep 500
send \.
sleep 500
send !a
sleep 500
send +{home}
sleep 500
send \DISPLAY1
sleep 500
send !a
sleep 500
send !{F4}
sleep 500
send {delete 6}
sleep 500
send Monitor Resolution
sleep 500
send {enter 2}
sleep 500
send +{end}
sleep 500
send +{left}
sleep 500
send ^c
sleep 500
send ^h
sleep 500
send ^v
sleep 500
send !a
sleep 500
send !{F4}
sleep 500
send {down}
sleep 500
send {delete 3}
sleep 500
send {down 4}
sleep 500
send +{end}
sleep 500
send +{left}
sleep 500
send ^c
sleep 500
send ^h
sleep 500
send ^v
sleep 500
send !a
sleep 500
send +{home}
sleep 500
send REG_DWORD
sleep 500
send !a
sleep 500
send !a
sleep 500
send !{F4}

msgbox,0,Hey listen,This is your display resolution,3
settitlematchmode,3
IfWinExist,cr.txt - Notepad
	{
		WinActivate
		send ^a
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 500
		send !n
	}
res = %Clipboard%

afterreg:

;; computer model number
RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
FileCopy, c:\780w7.txt, C:\thiscomputerinfo.txt
FileCopy, c:\780.txt, C:\thiscomputerinfo.txt
FileCopy, c:\LD610AD.txt, C:\thiscomputerinfo.txt
FileCopy, c:\LD620AD.txt, C:\thiscomputerinfo.txt
FileCopy, c:\LD620.txt, C:\thiscomputerinfo.txt
FileCopy, c:\745.txt, C:\thiscomputerinfo.txt
FileCopy, c:\755.txt, C:\thiscomputerinfo.txt
FileCopy, c:\780w72010.txt, C:\thiscomputerinfo.txt
ifexist,C:\thiscomputerinfo.txt
{
	fileread,thiscomputertxt,C:\thiscomputerinfo.txt
}
else
{
	loop, c:\*.txt
	thiscomputertxt = %A_LoopFileName%
}
;msgbox,0,0,res is '%res%'
RunWait %ComSpec% /C "del /F /Q c:\cr.txt"

;mailitall:
FoundPos := RegExMatch(thiscomputertxt, "(780)", modelnumber780)
FoundPos := RegExMatch(thiscomputertxt, "(745)", modelnumber745)
FoundPos := RegExMatch(thiscomputertxt, "(755)", modelnumber755)

StringReplace,roomnumber,roomnumber,`r`n,|,All
StringReplace,roomnumber,roomnumber,`,,,All
StringReplace,ieversion,ieversion,`r`n,|,All
StringReplace,ieversion,ieversion,`,,,All
StringReplace,reg,reg,`r`n,|,All
StringReplace,reg,reg,`,,,All
StringReplace,res,res,`r`n,|,All
StringReplace,res,res,`,,,All
StringReplace,winversion,winversion,`r`n,|,All
StringReplace,winversion,winversion,`,,,All
StringReplace,thiscomputertxt,thiscomputertxt,`r`n,|,All
StringReplace,thiscomputertxt,thiscomputertxt,`,,,All

fileappend,%A_YYYY%/%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%`,%roomnumber%`,%modelnumber780%`,%modelnumber755%`,%modelnumber745%`,%ieversion%`,%reg%`,%res%`,%winversion%`,%thiscomputertxt%`, `n,i:\it\t\computerCount\computerCount.txt


Run mailto:tyler.francis@humble.k12.tx.us?subject=Room`%20%roomnumber%`%20Computer`%20Information&body=Internet`%20Explorer`%20Version`%0A%ieversion%`%0A`%0A`%0A`%0AMicrosoft`%20Windows`%20Version`%0A%winversion%`%0A`%0A`%0A`%0A`%0A`%0A`%0A`%0ADisplay`%20Resolution`%0A`%0A`%0A`%0A`%0A`%0A%res%`%0A`%0ARegistry`%20Status`%0A%reg%`%0A`%0A`%0A`%0A`%0A`%0ARoom`%20Number`%0A%roomnumber%`%0A`%0A`%0A`%0A`%0A`%0AComputer`%20Model`%20Number`%0A%thiscomputertxt%`%0A
sleep 20000
run %ComSpec% /C "del /F /Q c:\ci.txt"
sleep 20000
Run %ComSpec% /C "del /F /Q c:\thiscomputerinfo.txt"
sleep 20000
send !d
msgbox,0,All Clear,It's all clear. Thanks for the info,5

exitapp

; gotos
; and
; hotkeys



esc::
{
	; msgbox,0,Fine geez,Exiting...,1
	Run %ComSpec% /C "del /F /Q c:\thiscomputerinfo.txt"
	run %ComSpec% /C "del /F /Q c:\ci.txt"
	ExitApp
}

movelogin:
{
	winmove,Two more things,Please log into GroupWise.,(A_ScreenWidth/2)-100,(A_ScreenHeight/4)
	return
}

exitapp
