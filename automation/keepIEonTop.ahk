;; keepIEonTop.ahk
;; version 1.4
;; Designed on 2015-09-02 by Tyler Francis to keep IE in the foreground. And then 'hide' the mouse. Please hold your applause.

#SingleInstance force
settitlematchmode,2
CoordMode,mouse,relative

loop
{
	winwait,Internet Explorer
	sleep 1000
	winactivate
	Winset,Alwaysontop,On,Internet Explorer
	sleep 2000
	mousemove,999999,0
;	WinWaitClose,Internet Explorer
	ifexist,..\stopkeepIEonTop.txt
	{
		Run, %ComSpec% /C "del /F /Q ..\stopkeepIEonTop.txt"
		Run, %comspec% /C "timeout /t 2 && del "%a_scriptname%""
		exitapp
	}
	sleep 900000
}

esc::exitapp
