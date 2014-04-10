; handyHotkeys.ahk v1.3
; just a bunch of stuff I would like to keep quickly accessable like typing the clipboard.

; Sleep Monitors
^Down::
{
	SendMessage 0x112, 0xF170, 2, , Program Manager
	return
}

; Lower Resolution
^NumPad1::
{
	Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1024" -height="768" -monitor="\\.\DISPLAY1""
	Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1024" -height="768" -monitor="\\.\DISPLAY2""
	return
}

; Increase Resolution 
^NumPad2::
{
	Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY1""
	Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY2""
	return
}

; Type Clipboard
^!v::
{
	sleep 700
	SetKeyDelay, 50
	SendRaw, %Clipboard%
	return
}

; Open Kronos
^!k::
{
	run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://kronos-as/wfc/applications/suitenav/navigation.do"
	sleep 20000
	run http://cd.justinjc.com/30m
	sleep 1800000
	run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://kronos-as/wfc/applications/suitenav/navigation.do"
	return
}
	
; Generic Timestamp
^!d::
{
	sleep 700
	send %A_YYYY%
	sleep 300
	send -
	sleep 300
	send %A_Mon%
	sleep 300
	send -
	sleep 300
	send %A_Mday%
	sleep 300
	send _
	sleep 300
	send %A_Hour%
	sleep 300
	send -
	sleep 300
	send %A_Min%
	sleep 300
	send -
	sleep 300
	send %A_Sec%
	sleep 300
	send +{left 9}
	return
}

; Printer datestamp
^!p::
{
	sleep 700
	send {home}
	sleep 100
	send +{end}
	sleep 100
	send ^v
	sleep 100
	send ` `-` 
	sleep 100
	send %A_YYYY%
	sleep 100
	send -
	sleep 100
	send %A_Mon%
	sleep 100
	send -
	sleep 100
	send %A_Mday%
	sleep 100
	send _
	sleep 100
	send %A_Hour%
	sleep 100
	send -
	sleep 100
	send %A_Min%
	sleep 100
	send -
	sleep 100
	send %A_Sec%
	sleep 100
	send {enter}
	return
}


;;Temporary hotkey
;^!t::


^!r::
{
	Reload
	Sleep 1000
	MsgBox,0,Failure,The script didn't restart properly!
	return
}


;; log off of computer
^!#+l::
{
	run M:\sjunk\ahk scripts\src\logout.ahk
	exitapp
}