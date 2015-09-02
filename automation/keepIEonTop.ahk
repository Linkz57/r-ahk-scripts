;; keepIEonTop.ahk
;; Designed on 2015-09-02 by Tyler Francis to keep IE in the foreground. And then 'hide' the mouse. Please hold your applause.

#SingleInstance force
settitlematchmode,2
CoordMode,mouse,relative

loop
{
	winwait,Windows Internet Explorer
	sleep 1000
	winactivate
	Winset,Alwaysontop,On,Windows Internet Explorer
	sleep 2000
	mousemove,999999,0
	WinWaitClose,Windows Internet Explorer
}
