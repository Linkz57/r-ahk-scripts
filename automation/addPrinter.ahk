;; addPrinter.ahk

#SingleInstance ignore
printer = something broke--press ESC now
hostName = something broke--press ESC now
humanName = something broke--press ESC now


if A_OSVersion in WIN_XP
{
	msgbox,0,Sorry buddy,Apologies`, but Windows XP (the 12-year-old operating system you're using) doesn't work well with networked printers.,60
	exitapp
}

SetTimer,ChangeButtonNames,50
msgbox,3,Install printer script v3,Do you want to install the big printer/scanner in room 1100f (the 1100-1200 workroom) `n`nOr from the 2301 workroom?`n`nYou could choose both`, but pick one now and you can run this program again and pick the other later.,120
IfMsgBox CANCEL
{
	MsgBox,0,Nothing Installed,Ok some other time maybe,10
	exitapp
}
IfMsgBox TIMEOUT
{
	MsgBox,0,OK I'm bored now,You took too long and I lost interest. `nRun me again once you've made up your mind.,120
	exitapp
}

IfMsgBox YES ; 1100f
{
	printer = 1100f
	hostName = rnp0026736dee83
	humanName = 1100f - RICOH Pro 8110S
}

IfMsgBox NO ; 2301
{
	printer = 2301
	hostName = rnp0026737e405a
	humanName = 2301 - RICOH Pro 8110S
}

msgbox,0,Alright`, hands off,OK I'm about to install the %printer% printer and scanner. Sit back`, relax`, and under no circumstances touch the mouse or keyboard!`n`nAll of this is automated`, so keep your hands to yourself until I give you the all-clear at the end.,30
IfMsgBox OK
{
	msgbox,48,WOA WOA WOA,What did I JUST tell you??`n`nHands off`, bro. Stand up and walk away if you have to. Just stop touching things for like 5 minutes.,30
	IfMsgBox OK
	{
		msgbox,16,You know what? Fine.,If we're going to have a problem following directions`, then I'm not even going to try. `n`nLaunch this program again when you're ready to take this seriously.,20
		exitapp
	}
}
settitlematchmode,2
progress,FS10 W600 Y650,%A_Space% `n %A_Space%,Please Wait,The Unfaltering March Of `Progress,Segoe UI
run control printers
winwait,Devices and Printers
progress,2,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
winactivate
progress,5,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
Run,%ComSpec% /C "PnPutil.exe -i -a "OEMSETUP.INF" && timeout /t 15",I:\it\p\r\ricoh_pro_8110s\print\disk1
sleep 1500
progress,7,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,9,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,11,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,13,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,15,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,17,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,19,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
progress,20,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
sleep 2000
winactivate
send !f
sleep 2000
send d
winwait,Add a device,Windows will continue to look for new devices and display them here.
progress,30,About to actually add the printer,Please Wait,The Unfaltering March Of `Progress
sleep 10000
winactivate
send %humanName%
sleep 2000
progress,40,Actually adding the printer,Please Wait,The Unfaltering March Of `Progress
sleep 10000
winactivate
send !n
winwait,Add a device,To verify if this device finished installing properly
winclose

;; Done installing printer, now onto installing scanner with proper driver
sleep 10000
progress,50,If it looks like I'm grasping at straws here... I am.`nJust give me a bit.,Please Wait,The Unfaltering March Of `Progress
loop
{
	winclose,Properties
	sleep 1000
	winactivate,Devices and Printers
	sleep 5000
	send %humanName%
	sleep 1000
	send !{enter}
	sleep 5000
	ifwinexist,2301 - RICOH Pro 8110S Properties
	{
		break
	}
}
progress,60,Found it. See? I totally know what I'm doing.,Please Wait,The Unfaltering March Of `Progress
sleep 2000
send {right}
sleep 1000
send {tab}
sleep 1000
send WSD Scan Device
sleep 1000
send !r
sleep 2000
send +{tab}
sleep 1000
send {right}
sleep 1000
send !p
progress,65,Now installing the scanner,Please Wait,The Unfaltering March Of `Progress
winwait,Update Driver Software - WSD Scan Device
sleep 3000
winactivate
send !r
sleep 2000
send !l
sleep 5000
send !h
winwait,Install From Disk
sleep 5000
progress,75,Selecting the correct driver,Please Wait,The Unfaltering March Of `Progress
winactivate
sendraw I:\it\p\r\ricoh_pro_8110s\scan\Network
sleep 2000
send {enter}
sleep 5000
send +{tab}
sleep 1000
send +{tab}
sleep 1000
sendraw RICOH
sleep 1000
send {tab}
sleep 1000
send RICOH Pro 8110S
sleep 1000
send !n
progress,80,Ignoring safety warning...,Please Wait,The Unfaltering March Of `Progress
sleep 3000
ifwinexist,Update Driver Warning
{
	send !y
}
winwait,Update Driver Software - RICOH Pro 8100S WIA,RICOH Pro 8100S WIA
sleep 3000
winactivate
send !c
winclose,Properties
sleep 1000
winclose,Properties
sleep 1000
winactivate,Devices and Printers
sleep 1000
send %humanName%
sleep 1000
send !f
sleep 1000
send c
sleep 1000
send {enter}
progress,90,Specifically selecting the %printer% scanner,Please Wait,The Unfaltering March Of `Progress
winwait,Properties
sleep 2000
winactivate
send +{tab}
loop,3
{
	sleep 1000
	send {right}
}
sleep 1000
send !u
sleep 1000
send !i
sleep 1000
send %hostName%
sleep 1000
send !s
sleep 10000
send !o
sleep 5000
send {tab}
sleep 1000
send {tab}
sleep 1000
send {enter}
progress,100,%A_Space%,Done!,The Unfaltering March Of `Progress
sleep 2000
msgbox,0,All clear,All clear!`nyou're good to go. If you want to set your printer as the default`, right click on "%humanName%" and click "Set as default".`nIf you want to scan then I'd recommend dragging the printer called "%humanName%" to your desktop for easy access. Once it's there, right click it and select "Start scan".,60
msgbox,0,Oh and also,If you have any questions`, then you can email my creator Tyler.Francis@humble.k12.tx.us `nif you have to tell him I messed up then, well... please be nice about it. `nYou know he can be sometimes...,10
winclose,Devices and Printers
run control printers
send %humanName%
exitapp


return

ChangeButtonNames:
{
	IfWinNotExist, Install printer script
		return  ; Keep waiting.
	SetTimer, ChangeButtonNames, off 
	WinActivate 
	ControlSetText, Button1, &1100f 
	ControlSetText, Button2, &2301 
	return
}


exitapp

esc::exitapp
