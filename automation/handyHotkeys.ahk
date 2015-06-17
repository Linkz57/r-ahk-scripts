; handyHotkeys.ahk v1.6-work
; just a bunch of stuff I would like to keep quickly accessible like typing the clipboard.

; Sleep Monitors
^Down::
{
	SendMessage 0x112, 0xF170, 2, , Program Manager
	DllCall("LockWorkStation")
	return
}
^Up::
{
	SendMessage 0x112, 0xF170, 2, , Program Manager
	return
}

; Lower Resolution
; ^NumPad1::
; {
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1024" -height="768" -monitor="\\.\DISPLAY1""
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1024" -height="768" -monitor="\\.\DISPLAY2""
	; return
; }

; Increase Resolution 
; ^NumPad2::
; {
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY1""
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY2""
	; return
; }

; Type Clipboard
^!v::
{
	sleep 700
	SetKeyDelay, 50
	SendRaw, %Clipboard%
	return
}

; Open Kronos
; ^!k::
; {
	; run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://kronos-as/wfc/portal"
	; sleep 20000
	; run http://cd.justinjc.com/30m
	; sleep 1800000
	; run %ComSpec% /C ""C:\Program Files\Internet Explorer\iexplore.exe" http://kronos-as/wfc/portal"
	; return
; }
	
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
; ^!p::
; {
	; sleep 700
	; send {home}
	; sleep 100
	; send +{end}
	; sleep 100
	; send ^v
	; sleep 100
	; send ` `-` 
	; sleep 100
	; send %A_YYYY%
	; sleep 100
	; send -
	; sleep 100
	; send %A_Mon%
	; sleep 100
	; send -
	; sleep 100
	; send %A_Mday%
	; sleep 100
	; send _
	; sleep 100
	; send %A_Hour%
	; sleep 100
	; send -
	; sleep 100
	; send %A_Min%
	; sleep 100
	; send -
	; sleep 100
	; send %A_Sec%
	; sleep 100
	; send {enter}
	; return
; }

;speak selected text, stolen from this guy https://stackoverflow.com/questions/21175199/how-do-i-stop-sapi-spvoice-reading-is-as-island
; ^!s::
; {
	; ClipSaved := ClipboardAll   
	; clipboard = ; Start off empty to allow ClipWait to detect when the text has arrived.
	; Send ^c
	; ClipWait  ; Wait for the clipboard to contain text.
	; ComObjCreate("SAPI.SpVoice").Speak(clipboard)
	; Clipboard := ClipSaved 
	; ClipSaved = ; Free the memory 
	; return
; }

; speak selected text with Google TTS, stolen and then edited from this guy http://www.autohotkey.com/board/topic/64269-google-text-to-speech-tts/
; ^!s::
{
	SendMode Input
	SetWorkingDir %A_ScriptDir%
	SetBatchLines, -1
	lang = en
	Runwait %ComSpec% /C "rmdir /s /q c:\GoogleSpeech"
	FileCreateDir, c:\GoogleSpeech ; makes folder in temp folder
	; FileDelete, c:\GoogleSpeech\%Input%.mp3 ; gets rid of existing speech file
	ClipSaved := ClipboardAll
	clipboard = ; Start off empty to allow ClipWait to detect when the text has arrived.
	Send ^c
	ClipWait  ; Wait for the clipboard to contain text.
	stringreplace, clipboard, clipboard, `r,,all
	stringreplace, clipboard, clipboard, `n,%A_Space%,all
	Clipboard .= " " ; seems to help
	Clipboard := RegExReplace(Clipboard, "(.{1," . Count . "})[ ]", "$1`n")
	StringSplit, Array, Clipboard, `n
	Loop, %Array0%
	{
		contains:= Array%a_index%
		;MsgBox, Array number %a_index%`n %contains%.
		UrlDownloadToFile, http://translate.google.com/translate_tts?tl=en&q=%clipboard%`., c:\GoogleSpeech\tts%a_index%.mp3
		Soundplay, c:\GoogleSpeech\tts%a_index%.mp3, Wait
		; PlayTTS(contains, lang, volume)
	}
	; ComObjCreate("SAPI.SpVoice").Speak(clipboard)

	; sendraw %clipboard%
	listvars
	pause
	; cleanString := uriEncode(clipboard)
	; UrlDownloadToFile, http://translate.google.com/translate_tts?tl=en&q=%clipboard%`., c:\GoogleSpeech\%Input%.mp3
	Clipboard := ClipSaved 
	ClipSaved = ; Free the memory 
	; Soundplay, c:\GoogleSpeech\%Input%.mp3, Wait ; plays the downloaded speech file and waits for it to finish
	return
}

; speak selected text with Google TTS v2, stolen from this guy and then hacked up http://www.autohotkey.com/board/topic/70728-split-string-into-array-of-max-100-characters/

exitapp

; ^!s::
{
	SendMode Input
	SetWorkingDir %A_ScriptDir%
	SetBatchLines, -1
	lang = en
	send ^c
	ClipWait  ; Wait for the clipboard to contain text.
	sleep 1000
	play(clipboard)
	return
}
;;Temporary hotkey
^!t::
loop,1000
{
;sleep 100
click
}
return


^!r::
{
	Reload
	Sleep 1000
	MsgBox,0,Failure,The script didn't restart properly!
	return
}

;; disable Notepad++ document switcher
RButton::click right
RButton & WheelDown::
{
	sleep 1
	return
}
RButton & WheelUp::
{
	sleep 1
	return
}

;; log off of computer
; ^!#+l::
; {
	; run M:\sjunk\ahk scripts\src\logout.ahk
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY1""
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY2""
	; exitapp
; }

;; shut down computer
; ^!#+s::
; {
	; del /F /Q shutdown.txt
	; run M:\sjunk\ahk scripts\src\logout.ahk
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY1""
	; Runwait %ComSpec% /C ""C:\Program Files\12noon Display Changer\dc.exe" -width="1280" -height="1024" -monitor="\\.\DISPLAY2""
	; sleep 1000
	; Runwait %ComSpec% /C "echo shutdown > shutdown.txt"
	; exitapp
; }






;;functions and gotos



uriEncode(str)
{ ; v 0.3 / (w) 24.06.2008 by derRaphael / zLib-Style release
   b_Format := A_FormatInteger
   data := ""
   SetFormat,Integer,H
   Loop,Parse,str
      if ((Asc(A_LoopField)>0x7f) || (Asc(A_LoopField)<0x30) || (asc(A_LoopField)=0x3d))
         data .= "%" . ((StrLen(c:=SubStr(ASC(A_LoopField),3))<2) ? "0" . c : c)
      Else
         data .= A_LoopField
   SetFormat,Integer,%b_format%
   return data
}
;%




play(stuf) {
	;gui, submit, nohide
	Count=100
	stringreplace, clipboard, clipboard, `r,,all
	stringreplace, clipboard, clipboard, `n,%A_Space%,all
	Clipboard .= " " ; seems to help
	Clipboard := RegExReplace(Clipboard, "(.{1," . Count . "})[ ]", "$1`n")
	StringSplit, Array, Clipboard, `n
	Loop, %Array0%
	{
		contains:= Array%a_index%
		;MsgBox, Array number %a_index%`n %contains%.
		PlayTTS(contains, lang, volume)
	}
	return
}


PlayTTS(String="",lang="EN", volume=100, bassDLLpath=""){
global tssh_old
; langs := "AF SQ HY CN DA DE EN FI FR EL " _
; . "EL HT HI ID IS IT JA CA KO HR LA " _
; . "LV LT MK NL NO PL PT RO RU SV SR " _
; . "SK ES SW CS TR UK HU VI CY"
if strlen(String) > 100
{
   msgbox,16,, String too long, a maximum of 100 characters!
   return 0
}
; if !instr(langs, lang)
; {
   ; msgbox,16,, Unsupported language!
   ; return 0
; }
DllCall("LoadLibrary", Str, bassDLLpath = "" ? A_WorkingDir . "\bass.dll" : bassDLLpath)
$url := "http://translate.google.com/translate_tts?q=" . uriEncode(String) . "&tl=en"
DllCall("bass\BASS_StreamFree", UInt, TSSh)
DllCall("bass\BASS_Init", Int, -1, Int, 44100, Int, 0, UInt, 0, UInt, 0)
TSSh := DllCall("bass\BASS_StreamCreateURL", Astr, $url, UInt, 0, UInt, 0, UInt, 0, UInt, 0)
if TSSh = 0
   return 0
volu := volume > 100 ? 100 : volume / 100
DllCall("bass\BASS_ChannelSetAttribute", UInt, TSSh, UInt, 2, Float, volu)

DllCall("bass\BASS_ChannelPlay", UInt, TSSh, Int, 0)
	loop
	{
		BASS_ACTIVE:=DllCall("BASS\BASS_ChannelIsActive", UInt,TSSh_old) 	
		If bass_Active = 1
		DllCall("bass\BASS_ChannelPause", UInt, TSSh, Int, 0)
		else
		{
		DllCall("bass\BASS_ChannelPlay", UInt, TSSh, Int, 0)
		break
		}
	}
Tssh_old := Tssh
return 1
}
