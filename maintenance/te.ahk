;;;; te.ahk v3.1
;;;; The idea is, I test a computer for TestNav compatibility and try to fix any issues I find.
ranUAatLeastOnce = false
firstCheck = fail
buttonClicked = notsure
testFailCount = 0
randomX = 220
randomY = 330
runwait QRes.exe /x 1280 /y 1024
sleep 500
goto,testbegin



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



;;test begin
testbegin:
Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
if testFailCount > 3
{
	msgbox,0,Actually you know what?,This test has failed too many times. I obviously don't know what I'm doing, so I'll defer discernment to you`, human.
	Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://tx.testnav.com/txqc"
	exitapp
}
sleep 2000
Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" -k https://proctorcaching.pearsonaccess.com/ems/systemCheck/systemCheck.jsp?acc=tx"
if buttonClicked in notsure
{
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
			Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://tx.testnav.com/txqc"
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
	IfWinExist,Security Information
	{
		WinActivate
		send !d
		sleep 500
		send !r
		sleep 3000
	}
	IfWinExist,Internet Explorer,Internet Explorer is not currently your default browser.
	{
		WinActivate
		send !y
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
	if buttonClicked in notsure
	{
		click 220,330
	}
}

IfWinExist,Security Warning
{
	send {left}
	sleep 500
	send {space}
}
IfWinExist,Security Information
{
	WinActivate
	send !d
	sleep 500
	send !r
	sleep 3000
}
IfWinExist,Internet Explorer,Internet Explorer is not currently your default browser.
{
	WinActivate
	send !y
}
IfWinExist,Internet Explorer,The page you are viewing uses Java. More information on Java support is available from the Microsoft website.
{
	WinActivate
	send !d
	sleep 500
	send {enter}
}
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
IfWinExist,Internet Explorer 9 - Microsoft Windows - Windows Internet Explorer
{
	WinActivate
	sleep 500
	send ^w
}
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
IfWinExist,System Check for TestNav - Windows Internet Explorer
WinActivate
IfWinExist,Choose Add-ons
{
	WinActivate
	sleep 500
	send !d
}

sleep 5000
if buttonClicked in false
{
	random,randomX,210,230
	random,randomY,320,340
	click %randomX%,%randomY%
}
sleep 3000
IfWinExist,Message from webpage,Java version blocked or not installed.
{
	Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
	msgbox,0,Fail,It seems java is not up to date. I'm going to try to update it now.,5
	goto,uabegin
}
sleep 10000
;;check for passed test
SetTitleMatchMode,2
IfWinExist,Internet Explorer
{
	winactivate
	sleep 500
	send ^a
	sleep 500
	send ^c
	sleep 500
	Run %ComSpec% /C "C:\windows\system32\notepad.exe"
	sleep 2000
	SetTitleMatchMode,1
	IfWinExist,Untitled - Notepad
	{
		winactivate
		send ^v
		sleep 1000
		send ^{home}
		sleep 500
		send ^f
		sleep 500
		send All Checks Passed.
		sleep 500
		send {enter}
		sleep 500
		send !{F4}
		sleep 500
		send ^c
		firstCheck = %clipBoard%
		if firstCheck in All Checks Passed.
		{
			buttonClicked = true
			msgbox,0,Good news everyone,It seems the first test passed. I'll move on to the second one now.,5
		}
		else
		{
			msgbox,0,0,The test seems to have failed. Let me see `if it it was my fault or not.,5
			winactivate,Untitled - Notepad
			sleep 500
			send ^{home}
			sleep 500
			send ^f
			sleep 500
			send Checks Failed.
			sleep 500
			send {enter}
			sleep 500
			send !{F4}
			sleep 500
			send ^c
			firstCheck = %clipBoard%
			if firstCheck in Checks Failed.
			{
				if testFailCount > 1 
				{
					msgbox,0,Ok this is getting old,The test has failed twice now. I'm going to update the whole system and try again after that.
					goto,testBegin
				}
				msgbox,0,well this is new,Well what do you know`, it actually wasn't my fault. I'll try the test again and then try updating the system to fill any missing holes in the test requisite.,7
				testFailCount ++
				goto,testBegin
			}
			else
			{
				msgbox,0,The test failed,The test failed. I'll try again assuming I just missed the button.,5
				buttonClicked = false
				Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
				Run %ComSpec% /C "taskkill /F /IM notepad.exe"
				testFailCount ++
				goto,testBegin
			}
		}
	}
}
else
{
	msgbox,0,Well This is odd,I can't find IE
}
Runwait %ComSpec% /C "timeout /t 60"
SetTitleMatchMode,2
WinActivate,Internet Explorer

;; moving on to the second check
secondcheck:
sleep 2000
Run %ComSpec% /C "taskkill /F /IM iexplore.exe"
sleep 5000
Run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" -k http://tx.testnav.com/txqc"
sleep 10000
IfWinExist,Security Information
{
	WinActivate
	send !d
	sleep 500
	send !r
}
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
