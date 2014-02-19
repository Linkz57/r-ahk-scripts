; logout.ahk v2
; the idea is I close a bunch of programs then open Truecrypt and then shutdown.

;	closing firefox
SetTitleMatchMode,2
ifwinexist,  - Mozilla Firefox
{
	winactivate
	sleep 1000
	msgbox,0,Closing Firefox,Closing Firefox,1
	Winclose
}
else
{
	msgbox,0,whelp,I couldn't find Firefox.,2
}



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



;	closing wintabs
msgbox,0,Closing WindowTabs,Closing WindowTabs,1
process,exist,WindowTabs.exe
while (%errorlevel% != 0)
{
	if (%A_Index% > 3)
	{
		Runwait %ComSpec% /C "taskkill /F /IM WindowTabs.exe"
	}
	Runwait %ComSpec% /C "taskkill /IM WindowTabs.exe"
	sleep 1000
	process,exist,WindowTabs.exe
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



; opening TrueCrypt
sleep 2000
run C:\Users\student\Documents\TrueCrypt\TrueCrypt.exe
Runwait %ComSpec% /C "shutdown /s /t 300"
exitapp
