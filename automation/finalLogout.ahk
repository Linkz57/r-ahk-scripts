sleep 5000
send !s
sleep 7000
ifwinexist,TrueCrypt,Some volumes contain files or folders being used by applications or system.
{
	Run %ComSpec% /C ""%ProgramFiles%\Windows Media Player\wmplayer.exe" C:\windows\media\town.mid"
	msgbox,4,What now?,Want me to `run the logout script again?,15
	IfMsgBox Yes
	{
		run M:\sjunk\ahk scripts\src\logout.ahk
		exitapp
	}
	IfMsgBox No
	{
		exitapp
	}
	IfMsgBox Timeout
	{
		WinGet, id, list, , , Program Manager
		Loop, %id%
		{
			StringTrimRight, this_id, id%a_index%, 0
			WinGetTitle, this_title, ahk_id %this_id%
			winclose,%this_title%
		}
		run M:\sjunk\ahk scripts\src\logout.ahk
		exitapp
	}
}
send !x
sleep 2000
SendMessage 0x112, 0xF170, 2, , Program Manager