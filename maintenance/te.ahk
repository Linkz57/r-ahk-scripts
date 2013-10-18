sleep 500
computerbegin:
sleep 500
runwait QRes.exe /x 1280 /y 1024
sleep 500
goto,testbegin
msgbox,48,error,Error! This line should never be seen
uabegin:
sleep 5000
SetTimer,altr,-10000
runwait ua.exe
sleep 5000
goto,testbegin
msgbox,48,error,Error! This line should never be seen
testbegin:
Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" https://proctorcaching.pearsonaccess.com/ems/systemCheck/systemCheck.jsp?acc=tx"
sleep 15000
IfWinExist,Java Update Needed
{
	Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
	msgbox,48,Fail,It seems java is not up to date. I'm going to try to update it now.,5
	goto,uabegin
}
sleep 5000
IfWinExist,Security Warning
{
	send {left}
	sleep 500
	send {space}
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
sleep 5000
IfWinExist,Internet Explorer 9 - Microsoft Windows - Windows Internet Explorer
{
	WinActivate
	sleep 500
	send ^w
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
send {F11}
sleep 3000
send ^0
sleep 1000
click 220,338
sleep 10000
Runwait %ComSpec% /C "timeout /t 60"

;; moving on to the second check
sleep 2000
Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
sleep 5000
Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://tx.testnav.com/txqc"
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
sleep 5000
IfWinExist,TestNav - Windows Internet Explorer
WinActivate
sleep 500
send {F11}
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

altr:
send !r
return

sleep 3000
;run uspa.txt
Esc::
msgbox,0,k,k,1
exitapp
