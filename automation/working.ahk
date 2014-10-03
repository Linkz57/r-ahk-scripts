;; working.ahk v1

#SingleInstance ignore

run wordpad
SetTimer,ChangeButtonNames,50
msgbox,4096,Take a nap,You've been working too hard for too long.`nSit back`, relax`, and let me do some of the writing for you.`n`nPress ESC when you want me to stop working.,15

settitlematchmode,2
winwait, - WordPad
sleep 1000
winactivate
winmaximize

loop
{
	random,rand,0,150
	sleep %rand%
	SetKeyDelay,%rand%,0
	winactivate, - WordPad
	send All work and no play makes Amanda a dull girl. ` ` 
}

esc::
{
	SetKeyDelay,100,50
	send {enter}
	sleep 200
	send ^b
	sleep 200
	send ^i
	sleep 200
	send NoW iT's PlAy TiMe
	SetKeyDelay,1000,-1
	sleep 1000
	send ` ...
	send ^b
	send ^i
	exitapp
}



return

ChangeButtonNames:
{
	IfWinNotExist,Take a nap
		return  ; Keep waiting.
	SetTimer, ChangeButtonNames, off 
	WinActivate 
	ControlSetText, Button1, &Trust Me
	return
}
