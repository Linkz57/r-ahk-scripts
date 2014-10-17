; TeacherHotKeys.ahk v1.5
; just a bunch of stuff I would like to keep quickly accessible like typing the clipboard.

; Sleep Monitors
; ^Down::
; {
	; SendMessage 0x112, 0xF170, 2, , Program Manager
	; return
; }


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
	settitlematchmode,2
	run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://kronos-as/wfc/portal"
	sleep 20000
	run http://cd.justinjc.com/30m
	winwait,CD:
	winactivate, - Internet Explorer
	sleep 1800000
	run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://kronos-as/wfc/portal"
	return
}
	
	
; Generic Timestamp
^!t::
{
	sleep 700
	send %A_YYYY%
	; sleep 300
	send -
	; sleep 300
	send %A_Mon%
	; sleep 300
	send -
	; sleep 300
	send %A_Mday%
	; sleep 300
	send _
	; sleep 300
	send %A_Hour%
	; sleep 300
	send -
	; sleep 300
	send %A_Min%
	; sleep 300
	send -
	; sleep 300
	send %A_Sec%
	sleep 300
	send +{left 9}
	return
}


;;datestamp hotkey
^!d::
{
	sleep 700
	send %A_YYYY%
	sleep 300
	send /
	sleep 300
	send %A_Mon%
	sleep 300
	send /
	sleep 300
	send %A_Mday%
	return
}


;speak selected text, stolen from this guy https://stackoverflow.com/questions/21175199/how-do-i-stop-sapi-spvoice-reading-is-as-island
^!s::
{
	ClipSaved := ClipboardAll   
	clipboard = ; Start off empty to allow ClipWait to detect when the text has arrived.
	Send ^c
	ClipWait  ; Wait for the clipboard to contain text.
	ComObjCreate("SAPI.SpVoice").Speak(clipboard)
	Clipboard := ClipSaved 
	ClipSaved = ; Free the memory 
	return
}
; return


; ^!r::
; {
	; Reload
	; Sleep 1000
	; MsgBox,0,Failure,The script didn't restart properly!
	; return
; }

