msgbox,0,thiscomputerinfo v2,Ok let's begin.`nThis script written by Tyler Francis wants to collect information about Internet Explorer`, Windows`, and your display resolution. `If you don't want this to happen`, press Esc now.`nIf at any time during this information collection you want me to stop`, press Esc (the key at the top left of your keyboard).`nWhen I'm done here I will attach the information I found to an email and wait for you to address and `send it.`n`nAre you ready?,60

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
		RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
		msgbox,0,Sorry about this,Sorry but I'm unable to get access to the specific information your want. Here's all of the information instead.,15
		run %ComSpec% /C "msinfo32"
		sleep 3000
		IfWinExist,System Information
		{
			winactivate
			sleep 500
			exitapp
		}
		else
		{
			msgbox,0,Well this is just embarrassing,It seems I'm ALSO unable to give you all of the information. Let me try something else...,15
			send #{pause}
			sleep 5000
			IfWinExist,System
			{
				winactivate
				sleep 500
				exitapp
			}
			else
			{
				msgbox,0,What is wrong with me?!,Ugh I just can't get anything right! One last ditch effort before I crash in frustration and inner turmoil.,7
;				fallback:
				FileCopy, c:\780w7.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\780.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\LD610AD.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\LD620AD.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\LD620.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\745.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\755.txt, C:\thiscomputerinfo.txt
				FileCopy, c:\780w72010.txt, C:\thiscomputerinfo.txt
				msgbox,At least something worked,Sorry but this is all the information I could get for you...,5
				Run %ComSpec% /C "iexplore"
				sleep 2000
				send !{h}
				sleep 500
				send a
				sleep 1000
				msgbox,0,Internet Explorer,Here's your Internet Explorer version
				Run %ComSpec% /C "control desk.cpl"
				msgbox,0,Screen Resolution,Here's your Screen Resolution
				SetTimer,osversionmsg,-1000
				RunWait %ComSpec% /C "c:\thiscomputerinfo.txt"
				sleep 1000
				Run %ComSpec% /C "del /F /Q c:\thiscomputerinfo.txt"
				sleep 1000
				exitapp
			}
		}
	}
	else
	{
		msgbox,0,Someone set us up the segfault,Something happened and I don't know what--only that it shouldn't have happened. Don't worry I mean nothing broke necessarily. `nI'll try to put you back on the right path...,10
;		goto,fallback
		sleep 2000
		msgbox,0,lolnope,error errorlevel
		exitapp
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
msgbox,0,Hey listen,This is your version of Internet Explorer,10
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
msgbox,0,Hey listen,This is your version of Microsoft Windows,10
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

msgbox,0,Hey listen,This is your display resolution,10
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
;msgbox,0,0,res is '%res%'
RunWait %ComSpec% /C "del /F /Q c:\cr.txt"

;mailitall:
msgbox,4,That's all folks,That's all of the information I thought you might be interested in. Would you like me to email all of it to someone?,15
IfMsgBox No
{
	msgbox,0,Hey no skin off my motherboard,Alright well I guess I'm done here. Have a good day.,5
	exitapp
}
IfMsgBox Yes
{
	Run mailto:?subject=Computer`%20Information&body=Internet`%20Explorer`%20Version`%0A%ieversion%`%0A`%0A`%0A`%0AMicrosoft`%20Windows`%20Version`%0A%winversion%`%0A`%0A`%0A`%0ADisplay`%20Resolution`%0A`%0A%res%
	sleep 2000
	exitapp
}
IfMsgBox Timeout
{
	Run mailto:tyler.francis@humble.k12.tx.us?subject=Computer`%20Information&body=Internet`%20Explorer`%20Version`%0A%ieversion%`%0A`%0A`%0A`%0AMicrosoft`%20Windows`%20Version`%0A%winversion%`%0A`%0A`%0A`%0ADisplay`%20Resolution`%0A`%0A%res%
	sleep 10000
	run %ComSpec% /C "del /F /Q c:\ci.txt"
	sleep 5000
	send !d
	sleep 5000
	run %ComSpec% /C "shutdown /s /t 90"
	exitapp
}

exitapp

; gotos
; and
; hotkeys

osversionmsg:
{
	msgbox,0,Operating System,Here's your Operating System version
	return
}

esc::
{
	msgbox,0,Fine geez,Exiting...,1
	ExitApp
}
