; delayedStartup.ahk v 1.1

coldboot = false
IfWinNotExist, Novell GroupWise - Unread
{
	coldboot = true
	sleep 30000
	run C:\Novell\GroupWise\grpwise.exe
	sleep 10000
}
aftergw:
IfWinExist, Novell GroupWise - Unread
{
	run C:\Users\student\Documents\TrueCrypt\TrueCrypt.exe
	loop
	{
		sleep 30000
		IfExist, M:\
		{
			break
		}
	}

	run M:\sjunk\Start.exe
	sleep 10000
	run M:\sjunk\PortableApps\FirefoxPortable\FirefoxPortable.exe
	sleep 20000
	run M:\sjunk\PortableApps\Launchy\Launchy.exe
	sleep 10000
	run M:\sjunk\PortableApps\TexterPortable\TexterPortable.exe
	sleep 10000
	run M:\sjunk\PortableApps\WindowTabs\WindowTabs.exe
	sleep 10000
	if coldboot in false
	{
		run C:\Novell\GroupWise\notify.exe
	}
	sleep 10000

	run M:\sjunk\ahk scripts\src\handyHotkeys.ahk
	;msgbox,0,oh poop, the handyHotkey died! ; diagnostics
}
else
{
	sleep 20000
	goto aftergw
}
