process,close,iexplore.exe
sleep 2000
Run %ComSpec% /C "Inetcpl.cpl"

if A_OSVersion in WIN_VISTA ; this script is IE9 specific. IE9 is Vista+ specific. This isn't a full-proof check, but it's better than nothing.
{
    sleep 3000
    loop, 6
    {
    Send ^{tab}
    sleep 200
    }
    sleep 300
    send {tab}
	sleep 200
	send {tab}
	sleep 200
	send {enter}
	sleep 1000
	send {tab}
	sleep 200
	send {space}
	sleep 200
	send {tab}
	sleep 200
	send {tab}
    sleep 200
    send {enter}
    sleep 10000
    send {enter}
    sleep 500
;    Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
    Sleep, 500
    Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "https://google.com" /F"
    Sleep, 1000
    Run, iexplore.exe,,max
	sleep 10000
	IfWinExist,Set Up Windows Internet Explorer 9
	{
		loop,4
		{
			send {tab}
			sleep 500
		}
		send {space}
		sleep 500
		loop,2
		{
			send {tab}
			sleep 500
		}
		send {down}
		sleep 500
		send {enter}
		sleep 500
		loop,2
		{
			send {tab}
			sleep 500
		}
		send {enter}
	}
	IfWinExist,Windows Internet Explorer 9
	{
		sleep 1000
		send {space}
		sleep 200
		send {enter}
	}
	sleep 500
	IfWinExist,Your browser has been upgraded - Microsoft Windows - Windows Internet Explorer
	{
		sleep 2000
		send ^w
	}
	sleep 500
}
else
{
    MsgBox,0,Sorry,This only works with Internet Explorer 9
	exitapp
}
exitapp
esc::
{
    Run %ComSpec% /C "explorer"
	ExitApp
}