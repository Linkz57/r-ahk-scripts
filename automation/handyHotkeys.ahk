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
	return
}
	
; Timestamp
^!d::
{
	sleep 700
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
	return
}



^!r::
{
	Reload
	Sleep 1000
	MsgBox,0,Failure,The script didn't restart properly!
	return
}
