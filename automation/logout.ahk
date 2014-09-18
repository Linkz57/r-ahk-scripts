; logout.ahk v2.4
; the idea is I close a bunch of programs then open Truecrypt.

;	closing firefox

Run %ComSpec% /C "shutdown /r /t 600

process,exist,firefox.exe
while (%errorlevel% != 0)
{
	SetTitleMatchMode,2
	ifwinexist,  - Mozilla Firefox
	{
		winrestore,  - Mozilla Firefox
		sleep 1000
		Winclose,  - Mozilla Firefox
		msgbox,0,Closing Firefox,Closing Firefox,1
	}
	else
	{
		msgbox,0,gimmy a bit,Still waiting for Firefox to finish closing,2
	}
	sleep 2000
	process,exist,firefox.exe
}
msgbox,0,done,done,1

;	closing Chrome

process,exist,GoogleChromePortable.exe
while (%errorlevel% != 0)
{
	if (%A_Index% > 10)
	{
		Runwait %ComSpec% /C "taskkill /F /IM GoogleChromePortable.exe"
	}
	Runwait %ComSpec% /C "taskkill /F /IM chrome.exe"
	sleep 1000
	process,exist,GoogleChromePortable.exe
}
msgbox,0,done,done,1


;	closing Notepad++
process,exist,notepad++.exe
while (%errorlevel% != 0)
{
	SetTitleMatchMode,2
	ifwinexist,  - Notepad++
	{
		winactivate
		sleep 1000
		Winclose
		msgbox,0,Closing Notepad++,Closing Notepad++,1
	}
	else
	{
		msgbox,0,whelp,I couldn't find Notepad++.,2
	}
	sleep 2000
	process,exist,notepad++.exe
}
msgbox,0,done,done,1


;	closing workrave
msgbox,0,Closing workrave,Closing workrave,1
process,exist,Workrave.exe
while (%errorlevel% != 0)
{
	Runwait %ComSpec% /C "taskkill /F /IM Workrave.exe"
	sleep 1000
	process,exist,Workrave.exe
}
msgbox,0,0,done,1


;	closing texter
msgbox,0,Closing texter,Closing texter,1
process,exist,texter.exe
while (%errorlevel% != 0)
{
	if (%A_Index% > 3)
	{
		Runwait %ComSpec% /C "taskkill /F /IM texter.exe"
	}
	Runwait %ComSpec% /C "taskkill /IM texter.exe"
	sleep 1000
	process,exist,texter.exe
}
msgbox,0,0,done,1



;	closing PortableApps thing
SetTitleMatchMode,3
process,exist,PortableAppsPlatform.exe
while (%errorlevel% != 0)
{
	send ^!{space}
	sleep 1000
	ifwinexist,PortableApps.com Platform - M:\sjunk\PortableApps\PortableApps.com\PortableAppsPlatform.exe 
	{
		winactivate
		sleep 1000
		Winclose
		msgbox,0,Closing PortableApps thing,Closing PortableApps thing,1
	}
	sleep 1000
	process,exist,PortableAppsPlatform.exe
}
msgbox,0,0,done,1



;	closing Launchy
SetTitleMatchMode,3
process,exist,Launchy.exe
while (%errorlevel% != 0)
{
	send ^{space}
	sleep 1000
	ifwinexist,Launchy
	{
		winactivate
		sleep 1000
		Winclose
		msgbox,0,Closing Launchy,Closing Launchy,1
	}
	sleep 1000
	process,exist,Launchy.exe
}
msgbox,0,0,done,1



;	closing wintabs
msgbox,0,Closing WindowTabs,Closing WindowTabs,1
process,exist,WindowTabs.exe
while (%errorlevel% != 0)
{
	if (%A_Index% > 5)
	{
		msgbox,0,failed,Failed to close WindowTabs so go do it yourself,5
		break
	}
	Runwait %ComSpec% /C "taskkill /F /T /IM WindowTabs.exe"
	sleep 1000
	process,exist,WindowTabs.exe
}
msgbox,0,0,done,1



; opening TrueCrypt
sleep 2000
run C:\Users\student\Documents\TrueCrypt\TrueCrypt.exe
run C:\Users\student\Documents\finalLogout.ahk
;Runwait %ComSpec% /C "shutdown /s /t 300"
exitapp

esc::exitapp
