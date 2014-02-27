;;;; te.ahk v2.1
;;;; The idea is, I test a computer for TestNav compatibility and try to fix any issues I find.
ranUAatLeastOnce = false
runwait QRes.exe /x 1280 /y 1024
sleep 500
goto,testbegin

msgbox,48,error,Error! This line should never be seen

;;ua begin
uabegin:
sleep 5000
;; Keep UA from restarting when done
if A_OSVersion in WIN_7,WIN_VISTA
{
	RunWait %ComSpec% /C "echo foo > %HOMEDRIVE%%HOMEPATH%\Desktop\ahknorestart.txt"
}
if A_OSVersion in WIN_XP
{
	RunWait %ComSpec% /C "echo foo > "C:\Documents and Settings\student\Desktop\ahknorestart.txt""
}
SetTimer,altr,-10000
runwait ua.exe
ranUAatLeastOnce = true
sleep 5000
goto,testbegin

msgbox,48,error,Error! This line should never be seen

;;test begin
testbegin:
Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" -k https://proctorcaching.pearsonaccess.com/ems/systemCheck/systemCheck.jsp?acc=tx"
sleep 15000
IfWinExist,Java Update Needed
{
	if ranUAatLeastOnce in false
	{
		Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
		msgbox,0,Fail,It seems java is not up to date. I'm going to try to update it now.,5
		goto,uabegin
	}
	if ranUAatLeastOnce in true
	{
		msgbox,48,Picnic!,Well I've already tried updating it once so I won't try again. You'll have to test this thing thing manually.
		Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" -k http://tx.testnav.com/txqc"
		exitapp
	}
}
sleep 5000
IfWinExist,Security Warning
{
	send {left}
	sleep 500
	send {space}
}
IfWinExist,Internet Explorer,The page you are viewing uses Java. More information on Java support is available from the Microsoft website.
{
	WinActivate
	send !d
	sleep 500
	send {enter}
}
sleep 5000
IfWinExist,Windows Internet Explorer 9
{
	WinActivate
	sleep 500
	send {space}
	sleep 1000
	send {enter}
}
IfWinExist,Windows Internet Explorer 11
{
	WinActivate
	sleep 500
	send {space}
	sleep 1000
	send {enter}
}
sleep 5000
IfWinExist,Internet Explorer 9 - Microsoft Windows - Windows Internet Explorer
{
	WinActivate
	sleep 500
	send ^w
}
sleep 5000
loop,2
{
	IfWinExist,Security Information
	{
		WinActivate
		sleep 500
		send {enter}
	}
	sleep 10000
}
sleep 2000
IfWinExist,System Check for TestNav - Windows Internet Explorer
WinActivate
IfWinExist,Choose Add-ons
{
	WinActivate
	sleep 500
	send !d
}
sleep 1000
send !y
sleep 1000
;send {F11}
sleep 3000
send ^0
sleep 1000
click 220,330
sleep 3000
IfWinExist,Message from webpage,Java version blocked or not installed.
{
	Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
	msgbox,0,Fail,It seems java is not up to date. I'm going to try to update it now.,5
	goto,uabegin
}
sleep 10000
Runwait %ComSpec% /C "timeout /t 60"

;; moving on to the second check
secondcheck:
sleep 2000
Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
sleep 5000
Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" -k http://tx.testnav.com/txqc"
sleep 10000
IfWinExist,Java Update Needed
{
	Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
	msgbox,48,Fail,It seems java is still not up to date
	exitapp
}
sleep 5000
IfWinExist,Security Warning
{
	send {left}
	sleep 500
	send {space}
}
sleep 5000
IfWinExist,Security Warning
{
	WinActivate
	sleep 500
	send !y
}
sleep 10000
SetTitleMatchMode,2
IfWinExist,https://tx.testnav.com/ - TestNav
{
	WinActivate
	sleep 500
	;send {F11}
	sleep 2000
	send {tab}
	sleep 1000
	send systemcheck7
	sleep 500
	send {tab}
	sleep 500
	send testcode7
	sleep 1000
	send {enter}
	sleep 30000
	;Runwait %ComSpec% /C "timeout /t 60"
	loop,2
	{
		send {tab}
		sleep 500
	}
	send {space}
	sleep 1000
	loop,2
	{
		send {tab}
		sleep 500
	}
	loop,2
	{
		send {down}
		sleep 500
	}
	send {tab}
	sleep 500
	send {space}
	sleep 2000
	send {tab}
	sleep 500
	send {space}
	sleep 3000
	msgbox,0,Done!,Done!,20
	Run %ComSpec% /C "shutdown -s -t 10"
	exitapp
}
else
{
	goto,secondcheck
}

altr:
send !r
return

sleep 3000
;run uspa.txt
Esc::
msgbox,0,k,k,1
exitapp

