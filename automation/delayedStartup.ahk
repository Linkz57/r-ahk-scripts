sleep 30000
run C:\Novell\GroupWise\grpwise.exe
aftergw:
sleep 10000
IfWinExist, Novell GroupWise - Unread
{
	run E:\notlinux\TrueCrypt\TrueCrypt.exe
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
	run C:\Novell\GroupWise\notify.exe
	sleep 10000
	run M:\sjunk\ahk scripts\src\handyHotkeys.ahk
}
else
{
	sleep 20000
	goto aftergw
}
