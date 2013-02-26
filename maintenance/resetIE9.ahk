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
    send {tab}{tab}
    sleep 200
    send {enter}
    sleep 1000
    send {tab}
    sleep 200
    send {space}
    sleep 200
    send {tab}{tab}
    sleep 200
    send {enter}
    sleep 10000
    send {enter}
    sleep 500
    Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
    Sleep, 500
    Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
    Run, iexplore.exe,,max
}
else
{
    MsgBox,0,Sorry,This only works with Internet Explorer 9
	exitapp
}